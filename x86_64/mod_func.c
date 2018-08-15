#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;

extern void _hh_pump_reg(void);
extern void _hhrx_reg(void);

void modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," hh_pump.mod");
    fprintf(stderr," hhrx.mod");
    fprintf(stderr, "\n");
  }
  _hh_pump_reg();
  _hhrx_reg();
}
