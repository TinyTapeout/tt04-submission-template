import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

expected = [170]  # 10101010


@cocotb.test()
async def test_ttrng(dut):
    dut._log.info("starting test_ttrng!")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    dut._log.info("reset!")
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("check 10 random numbers")
    for i in range(10):
        dut._log.info("checking returned value {}".format(i))
        await ClockCycles(dut.clk, 1000)
        assert int(dut.number.value) == 170
