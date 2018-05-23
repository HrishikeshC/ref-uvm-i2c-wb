/////////////////////////////////////////////////////////////////////
////                                                             ////
////  I2C verification environment using the UVM                 ////
////                                                             ////
////                                                             ////
////  Author: Carsten Thiele                                     ////
////          carsten.thiele@enquireservicesltd.co.uk            ////
////                                                             ////
////                                                             ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2012                                          ////
////          Enquire Services                                   ////
////          carsten.thiele@enquireservicesltd.co.uk            ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//Simple Master Receive test.
class iicMasterRxTest extends iic_test_base;
 `uvm_component_utils(iicMasterRxTest)
 
 extern function new(string name = "iicMasterRxTest", uvm_component parent = null);
 extern task run_phase(uvm_phase phase);
 extern function void build_phase(uvm_phase phase);
 
endclass

function iicMasterRxTest::new(string name = "iicMasterRxTest", uvm_component parent = null);
 super.new(name, parent);
endfunction

function void iicMasterRxTest::build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

task iicMasterRxTest::run_phase(uvm_phase phase);
 iicTestBaseVseq m_iicTestVseq;

 iicTestBaseVseq::type_id::set_type_override(iicTest_MasterRx_Vseq::get_type(),1);
 iicDutTrafficBaseVseq::type_id::set_type_override(iicDutTraffic_MasterRx_Vseq::get_type(),1);
 iicXtTrafficBaseVseq::type_id::set_type_override(iicXtTraffic_MasterRx_Vseq::get_type(),1);

 m_iicTestVseq = iicTestBaseVseq::type_id::create("m_iicTestBaseVseq");

 phase.raise_objection(this,"iicMasterRxTest"); 
  #100;
  wait(!m_iicIf1.rst);
  #P_TESTRUNIN;
  if (!m_iicTestVseq.randomize())
   `uvm_fatal(m_name, "Unable to randomize test.")
  m_iicTestVseq.start(m_env.m_iic_virtual_sequencer);

  #P_TESTRUNOUT;
  phase.drop_objection(this,"iicMasterRxTest");

endtask
