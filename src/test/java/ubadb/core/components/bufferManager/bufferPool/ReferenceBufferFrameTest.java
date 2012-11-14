package ubadb.core.components.bufferManager.bufferPool;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

import ubadb.core.components.bufferManager.bufferPool.ReferenceBufferFrame;
import ubadb.core.testDoubles.DummyObjectFactory;
import ubadb.core.util.TestUtil;
import java.util.Date;

public class ReferenceBufferFrameTest 
{
	@Test
	public void testReferenceDateDistinctFrame() throws Exception
	{
		ReferenceBufferFrame bufferFrame0 = new ReferenceBufferFrame(DummyObjectFactory.PAGE);
		bufferFrame0.pin();
		Thread.sleep(TestUtil.PAUSE_INTERVAL); // Sleep to ensure that the second frame is referenced some time after the first
		ReferenceBufferFrame bufferFrame1 = new ReferenceBufferFrame(DummyObjectFactory.PAGE);
		bufferFrame1.pin();
		
		assertTrue(bufferFrame0.getReferenceDate().before(bufferFrame1.getReferenceDate()));
	}
	
	@Test
	public void testReferenceDateEqualsFrame() throws Exception
	{
		ReferenceBufferFrame bufferFrame = new ReferenceBufferFrame(DummyObjectFactory.PAGE);
		bufferFrame.pin();
		Date dateFrameP = bufferFrame.getReferenceDate();
		Thread.sleep(TestUtil.PAUSE_INTERVAL); // Sleep to ensure that the second reference is made some time after the first
		bufferFrame.unpin();
		Date dateFrameU = bufferFrame.getReferenceDate();
		
		assertTrue(dateFrameP.before(dateFrameU));
	}
}


