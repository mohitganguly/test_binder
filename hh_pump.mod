TITLE hh_pump.mod   squid sodium, potassium, and leak channels with temperature as a range variable

COMMENT

Modified from hh.mod so that temperature is controlled by RANGE variable localtemp  
Contains a temperature dependent pump, and a temperature dependent q10 function. 
Mohit Ganguly July 2017

 This is the original Hodgkin-Huxley treatment for the set of sodium,
  potassium, and leakage channels found in the squid giant axon membrane.
  ("A quantitative description of membrane current and its application
  conduction and excitation in nerve" J.Physiol. (Lond.) 117:500-544 (1952).)
 Membrane voltage is in absolute mV and has been reversed in polarity
  from the original HH convention and shifted to reflect a resting potential
  of -65 mV.
 Remember to set localtemp=6.3 (or whatever) in your HOC file.
 See squid.hoc for an example of a simulation using this model.
 SW Jaslove  6 March, 1992
ENDCOMMENT

UNITS {
        (mA) = (milliamp)
        (mV) = (millivolt)
        (S) = (siemens)
}

? interface
NEURON {
	THREADSAFE : assigned GLOBALs will be per thread
        SUFFIX hh_pump
        USEION na READ ena WRITE ina
        USEION k READ ek WRITE ik
        NONSPECIFIC_CURRENT il
        RANGE gnabar, gkbar 
        RANGE gl, el, gna, gk
	RANGE localtemp
	RANGE i
	RANGE minf, hinf, ninf, mtau, htau, ntau
        :GLOBAL minf, hinf, ninf, mtau, htau, ntau
        RANGE nacoeff, kcoeff
        :RANGE q10
}

PARAMETER {
        :gnabar = .12 (S/cm2)        <0,1e9>
        :gkbar = .036 (S/cm2)        <0,1e9>
        gl = .0003 (S/cm2)        <0,1e9>
        el = -54.3 (mV)
	
	
	
	una = -220 (mV) 
}

STATE {
        m h n :localtemp
}

ASSIGNED {
	
        v (mV)
        :celsius (degC)
        localtemp (degC)
        ena (mV)
        ek (mV)
	gnabar (S/cm2)
	gkbar (S/cm2)
        gna (S/cm2)
        gk (S/cm2)
        ina (mA/cm2)
        ik (mA/cm2)
        il (mA/cm2)
        i (mA/cm2)
        minf hinf ninf
        mtau (ms) htau (ms) ntau (ms)
        gnap (S/cm2)
        :q10
}

? currents
BREAKPOINT {
        SOLVE states METHOD cnexp
        gnap = 0.07e-4*(1.88)^((localtemp-6.3)/10) 
       
        gna = gnabar*m*m*m*h
        ina = gna*(v - ena)+3*gnap*(v-una)
        gk = gkbar*n*n*n*n
        ik = gk*(v - ek)-2*gnap*(v-una)
        il = gl*(v - el)
	i=ina+ik+il
}


INITIAL {
        rates(v)
        m = minf
        h = hinf
        n = ninf
	:localtemp=6.3
}

? states
DERIVATIVE states {
        rates(v)
        m' =  (minf-m)/mtau
        h' = (hinf-h)/htau
        n' = (ninf-n)/ntau
	
}

:LOCAL q10


? rates
PROCEDURE rates(v(mV)) {  :Computes rate and other constants at current v.
                      :Call once from HOC to initialize inf at resting v.
        LOCAL  alpha, beta, sum, q10, q10n, q10m, q10h
        :TABLE minf, mtau, hinf, htau, ninf, ntau DEPEND celsius FROM -100 TO 100 WITH 200
        :TABLE minf, mtau, hinf, htau, ninf, ntau DEPEND localtemp FROM -100 TO 100 WITH 200

UNITSOFF
        
        alpha = .1* vtrap(-(v+40),10)
        beta =  4* exp(-(v+65)/18)
        sum = alpha + beta
        mtau = 1/(q10(localtemp)*sum)
        minf = alpha/sum
                :"h" sodium inactivation system
        alpha = .07 * exp(-(v+65)/20)
        beta = 1/ (exp(-(v+35)/10) + 1)
        sum = alpha + beta
        htau = 1/(q10(localtemp)*sum)
        hinf = alpha/sum
                :"n" potassium activation system
        alpha = .01*vtrap(-(v+55),10)
        beta = .125*exp(-(v+65)/80)
        sum = alpha + beta
        ntau = 1/(q10(localtemp)*sum)
        ninf = alpha/sum
}

FUNCTION vtrap(x,y) {  :Traps for 0 in denominator of rate eqns.
        if (fabs(x/y) < 1e-6) {
                vtrap = y*(1 - x/y/2)
        }else{
                vtrap = x/(exp(x/y) - 1)
        }
}
FUNCTION q10(x) {  
        if (x <= 10) {
                q10 = 3^((x-6.3)/10)
        } if ((x>10) && (x<=20)) {
        	q10 = (1.50)*(2.9)^((x-10)/10)
        }if (x > 20){
                q10 = (1.50)*(2.9)*(2.2)^((x-20)/10)
        }
        :printf("%f \n", q10)
}

UNITSON
