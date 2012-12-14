package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount;

import static org.junit.Assert.assertTrue;

import org.junit.Test;
import ubadb.core.testDoubles.DummyObjectFactory;
import ubadb.core.util.TestUtil;

public class TouchCountBufferFrameTest
{
	@Test
	public void testTouchCountOnePin() throws Exception
	{
		TouchCountBufferFrame touchFrame = new TouchCountBufferFrame(DummyObjectFactory.PAGE, 3);
		touchFrame.pin();
		
		assertTrue(touchFrame.getTouchCount() == 1);
	}
	
	@Test
	public void testTouchCountPinUnpinEquals() throws Exception
	{
		TouchCountBufferFrame bufferFrame = new TouchCountBufferFrame(DummyObjectFactory.PAGE, 3);
		bufferFrame.pin();
		int tc0 = bufferFrame.getTouchCount();
		bufferFrame.unpin();
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
		assertTrue(tc0 + 1 == bufferFrame.getTouchCount());  
	}
	
	@Test
	public void testTouchCountBlast() throws Exception
	{
		TouchCountBufferFrame bufferFrame = new TouchCountBufferFrame(DummyObjectFactory.PAGE, 1);
		bufferFrame.pin();
		assertTrue(bufferFrame.getTouchCount() == 1);
		Thread.sleep(TestUtil.SLEEP_MORE_THAN_HALF_SECOND);

		bufferFrame.pin();
		assertTrue(bufferFrame.getTouchCount() == 1);
		Thread.sleep(TestUtil.SLEEP_MORE_THAN_HALF_SECOND);
		
		bufferFrame.pin();
		assertTrue(bufferFrame.getTouchCount() == 2);
	}
}
