package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount;

import static org.junit.Assert.assertTrue;

import org.junit.Test;
import ubadb.core.testDoubles.DummyObjectFactory;
import ubadb.core.util.TestUtil;

public class TouchCountBufferFrameTest
{
	@Test
	public void testTouchCount() throws Exception
	{
		TouchCountBufferFrame bufferFrame = new TouchCountBufferFrame(DummyObjectFactory.PAGE, 3);
		bufferFrame.pin();
		
		assertTrue(bufferFrame.getTouchCount() > 0);
	}
	
	@Test
	public void testTouchCountPinUnpinEquals() throws Exception
	{
		TouchCountBufferFrame bufferFrame = new TouchCountBufferFrame(DummyObjectFactory.PAGE, 3);
		bufferFrame.pin();
		int tc0 = bufferFrame.getTouchCount();
		bufferFrame.unpin();
		// tc0 y bufferFrame.getTouchCount() son iguales porque no pasaron 3 segundos entre el
		// evento del pin y el unpin
		assertTrue(tc0 == bufferFrame.getTouchCount());
	}
	
	@Test
	public void testTouchCountPinUnpingDistinct() throws Exception
	{
		TouchCountBufferFrame bufferFrame = new TouchCountBufferFrame(DummyObjectFactory.PAGE, 3);
		bufferFrame.pin();
		int tc0 = bufferFrame.getTouchCount();
		Thread.sleep(TestUtil.SLEEP_THREE_SECONDS); //Sleep to ensure they spend 3 seconds
		bufferFrame.unpin();
		// Aumento en 1 el touchCount pues pasaron 3 segundos
		assertTrue(tc0 == bufferFrame.getTouchCount() - 1);  
	}
}
