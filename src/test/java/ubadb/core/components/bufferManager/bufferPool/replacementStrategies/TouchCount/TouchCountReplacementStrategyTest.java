package ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount;

import static org.junit.Assert.assertEquals;

import java.util.Arrays;

import org.junit.Before;
import org.junit.Test;

import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.exceptions.PageReplacementStrategyException;
import ubadb.core.testDoubles.DummyObjectFactory;
import ubadb.core.util.TestUtil;

public class TouchCountReplacementStrategyTest
{
	private TouchCountReplacementStrategy strategy;
	
	@Before
	public void setUp(){
		int countIntervalSeconds = 1;
		int agingHotCriteria = 2;
		strategy = new TouchCountReplacementStrategy(countIntervalSeconds, agingHotCriteria);
	}
	
	@Test(expected=PageReplacementStrategyException.class)
	public void testNoPageToReplace() throws Exception
	{
		BufferFrame frame0 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame1 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		
		frame0.pin();
		frame1.pin();
		
		strategy.findVictim(Arrays.asList(frame0,frame1));
	}
	
	@Test
	public void testOnlyOneToReplace() throws Exception
	{
		BufferFrame frame0 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame1 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame2 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		
		frame0.pin();
		frame1.pin();
		
		assertEquals(frame2,strategy.findVictim(Arrays.asList(frame0,frame1,frame2)));
	}

	//Martin: La creacion del frame no genera fecha con lo que los sleep están de más.
	@Test
	public void testMultiplePagesToReplace() throws Exception
	{
		BufferFrame frame0 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame1 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame2 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		
		assertEquals(frame0,strategy.findVictim(Arrays.asList(frame0,frame1,frame2)));
	}

	//Martin: La creacion del frame no genera fecha con lo que los sleep están de más.
	@Test
	public void testMultiplePagesToReplaceButOldestOnePinned() throws Exception
	{
		BufferFrame frame0 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame1 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame2 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		
		frame0.pin();
		
		assertEquals(frame1,strategy.findVictim(Arrays.asList(frame0,frame1,frame2)));
	}
	
	/**
	 * First frame with high aging
	 * @throws Exception
	 */
	@Test
	public void testFirstWithHighAging() throws Exception{
		BufferFrame frame0 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame1 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		
		touchIt(frame0, 2);
		
		assertEquals(frame1,strategy.findVictim(Arrays.asList(frame0,frame1)));
	}
	
	
	/**
	 * Firsts frames with high aging
	 * @throws Exception
	 */
	@Test
	public void testFirstsWithHighAging() throws Exception{
		BufferFrame frame0 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame1 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame2 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame3 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		
		touchIt(frame0, 4);
		touchIt(frame1, 2);
		touchIt(frame2, 1);
		touchIt(frame3, 2);
		
		assertEquals(frame2,strategy.findVictim(Arrays.asList(frame0,frame1,frame2,frame3)));
	}
	
	/**
	 * All with high touchcount
	 * @throws Exception
	 */
	@Test(expected=PageReplacementStrategyException.class)
	public void testAllWithTouchCountHigh() throws Exception{
		BufferFrame frame0 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame1 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		BufferFrame frame2 = strategy.createNewFrame(DummyObjectFactory.PAGE);
		
		touchIt(frame0, 2);
		touchIt(frame1, 2);
		touchIt(frame2, 2);
		
		strategy.findVictim(Arrays.asList(frame0,frame1,frame2));
	}
	
	/**
	 * Pins and unpin the frame any amount of times. (Will touch it only once)
	 * @param frame the frame to be pin-unpin
	 * @param amount the amount of times
	 * @throws Exception
	 */
	private void touchIt(BufferFrame frame, int amount) throws Exception{
		
		int i = amount;
		while(i > 0){
			frame.pin();
			frame.unpin();
			Thread.sleep(TestUtil.SLEEP_ONE_SECOND);
			i--;
		}
	}
	
	
}
