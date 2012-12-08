package ubadb.core.components.bufferManager.bufferPool.pools.touchCount;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.pools.TouchCount.TouchCountBufferPool;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount.TouchCountBufferFrame;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount.TouchCountReplacementStrategy;
import ubadb.core.exceptions.BufferPoolException;
import ubadb.core.testDoubles.DummyObjectFactory;
import ubadb.core.util.TestUtil;

public class TouchCountBufferPoolTest 
{
	private TouchCountBufferPool bufferPool;
	private static final int POOL_MAX_SIZE = 3;
	private static final double PERCENT_HOT_DEFAULT = 50.0;
	
	private static final Page PAGE_0 = new Page(new PageId(0, DummyObjectFactory.TABLE_ID), "page0".getBytes());
	private static final Page PAGE_1 = new Page(new PageId(1, DummyObjectFactory.TABLE_ID), "page1".getBytes());
	private static final Page PAGE_2 = new Page(new PageId(2, DummyObjectFactory.TABLE_ID), "page2".getBytes());
	private static final Page PAGE_3 = new Page(new PageId(3, DummyObjectFactory.TABLE_ID), "page3".getBytes());
	
	@Before
	public void setUp()
	{
		int agingHotCriteria = 3;
		int countIntervalSeconds = 1;
		bufferPool = new TouchCountBufferPool(POOL_MAX_SIZE, PERCENT_HOT_DEFAULT, new TouchCountReplacementStrategy(countIntervalSeconds, agingHotCriteria));
	}
	
	@Test
	public void testIsPageInPoolTrue() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		
		assertTrue(bufferPool.isPageInPool(PAGE_0.getPageId()));
	}
	
	@Test
	public void testIsPageInPoolFalse() throws Exception
	{
		assertFalse(bufferPool.isPageInPool(PAGE_0.getPageId()));
	}
	
	/**
	 * @throws Exception
	 */
	@Test
	public void testPageIsNotInPoolTrue() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		
		assertTrue(!bufferPool.isPageInPool(PAGE_1.getPageId()));
	}
	
	@Test
	public void testGetExistingPage() throws Exception
	{
		BufferFrame expectedFrame = bufferPool.addNewPage(PAGE_0);
		
		assertEquals(expectedFrame, bufferPool.getBufferFrame(PAGE_0.getPageId()));
	}
	
	@Test
	public void testGetExistingPage2() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		BufferFrame frame1 = bufferPool.addNewPage(PAGE_1);
		
		assertEquals(frame1, bufferPool.getBufferFrame(PAGE_1.getPageId()));
	}
	
	@Test
	public void testHasSpaceTrue() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		assertTrue(bufferPool.hasSpace(PAGE_1.getPageId()));
	}
	
	@Test
	public void testHasSpaceFalse() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		
		assertFalse(bufferPool.hasSpace(PAGE_3.getPageId()));
	}
	
	@Test
	public void testAddNewPageWithSpace() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		
		assertEquals(2,bufferPool.countPagesInPool());
	}
	
	@Test(expected=BufferPoolException.class)
	public void testAddNewPageWithoutSpace() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		bufferPool.addNewPage(PAGE_3);
	}
	
	@Test(expected=BufferPoolException.class)
	public void testAddNewPageWithExisting() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_0);
	}
	
	@Test
	public void testNewPageIsUnpinnedAndNotDirtyByDefault() throws Exception
	{
		BufferFrame bufferFrame = bufferPool.addNewPage(PAGE_0);

		assertEquals(0,bufferFrame.getPinCount());
		assertFalse(bufferFrame.isDirty());
	}
	
	@Test
	public void testRemoveExistingPage() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		
		bufferPool.removePage(PAGE_0.getPageId());
		
		assertEquals(2,bufferPool.countPagesInPool());
		assertTrue(!bufferPool.isPageInPool(PAGE_0.getPageId()));
	}
	
	@Test(expected=BufferPoolException.class)
	public void testRemoveUnexistingPage() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		
		bufferPool.removePage(PAGE_3.getPageId());
	}
	
	@Test
	public void countPagesEmptyPool()
	{
		assertEquals(0, bufferPool.countPagesInPool());
	}
	
	@Test
	public void countPagesNonEmptyPool() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		
		assertEquals(3, bufferPool.countPagesInPool());
	}
	
	@Test(expected=BufferPoolException.class)
	public void testFindVictimWithSpace() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		
		assertEquals(PAGE_0,bufferPool.findVictim(PAGE_3.getPageId()).getPage());
	}
	
	@Test(expected=BufferPoolException.class)
	public void testFindVictimWithExistingPage() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		
		assertEquals(PAGE_0,bufferPool.findVictim(PAGE_2.getPageId()).getPage());
	}
	
	@Test
	public void testFindVictimInOrder() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		
		assertEquals(PAGE_0,bufferPool.findVictim(PAGE_3.getPageId()).getPage());
	}
	
	@Test
	public void testFindVictimAllWithLowTouchCount() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		
		bufferPool.getBufferFrame(PAGE_0.getPageId()).pin();
		bufferPool.getBufferFrame(PAGE_0.getPageId()).unpin();
		bufferPool.getBufferFrame(PAGE_1.getPageId()).pin();
		bufferPool.getBufferFrame(PAGE_1.getPageId()).unpin();
		bufferPool.getBufferFrame(PAGE_2.getPageId()).pin();
		bufferPool.getBufferFrame(PAGE_2.getPageId()).unpin();
		
		assertEquals(PAGE_0,bufferPool.findVictim(PAGE_3.getPageId()).getPage());
	}
	
	@Test
	public void testFindVictimMovingOneToHot() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		//In the list should be in this order: 0,2,1
		
		bufferPool.getBufferFrame(PAGE_0.getPageId()).pin();
		Thread.sleep(TestUtil.SLEEP_ONE_SECOND); //Sleep to ensure they spend 1 seconds
		bufferPool.getBufferFrame(PAGE_0.getPageId()).unpin();
		Thread.sleep(TestUtil.SLEEP_ONE_SECOND); //Sleep to ensure they spend 1 seconds
		bufferPool.getBufferFrame(PAGE_0.getPageId()).pin();
		Thread.sleep(TestUtil.SLEEP_ONE_SECOND); //Sleep to ensure they spend 1 seconds
		bufferPool.getBufferFrame(PAGE_0.getPageId()).unpin(); //TouchCount: 4

		bufferPool.getBufferFrame(PAGE_2.getPageId()).pin(); //TouchCount: 1 (Blocked)
		
		bufferPool.getBufferFrame(PAGE_1.getPageId()).pin(); 
		Thread.sleep(TestUtil.SLEEP_ONE_SECOND); //Sleep to ensure they spend 1 seconds
		bufferPool.getBufferFrame(PAGE_1.getPageId()).unpin(); //TouchCount: 2

		assertEquals(PAGE_1,bufferPool.findVictim(PAGE_3.getPageId()).getPage());
		assertEquals(0,((TouchCountBufferFrame)bufferPool.getBufferFrame(PAGE_0.getPageId())).getTouchCount()); //Page0 moved to Hot should have TouchCount 0 
		assertEquals(1,((TouchCountBufferFrame)bufferPool.getBufferFrame(PAGE_1.getPageId())).getTouchCount()); //Page1 moved to Cold should have TouchCount 1
		assertEquals(1,((TouchCountBufferFrame)bufferPool.getBufferFrame(PAGE_2.getPageId())).getTouchCount()); //Page2 didn't move
		
		bufferPool.getBufferFrame(PAGE_2.getPageId()).unpin(); //TouchCount: 2 (Unblocked)
		
		assertEquals(PAGE_2,bufferPool.findVictim(PAGE_3.getPageId()).getPage());
		
	}
	
	@Test
	public void testFindVictimMovingTwoToHot() throws Exception
	{
		bufferPool.addNewPage(PAGE_0);
		bufferPool.addNewPage(PAGE_1);
		bufferPool.addNewPage(PAGE_2);
		//In the list should be in this order: 0,2,1
		
		bufferPool.getBufferFrame(PAGE_0.getPageId()).pin();
		Thread.sleep(TestUtil.SLEEP_ONE_SECOND);
		bufferPool.getBufferFrame(PAGE_0.getPageId()).unpin();
		Thread.sleep(TestUtil.SLEEP_ONE_SECOND);
		bufferPool.getBufferFrame(PAGE_0.getPageId()).pin();
		Thread.sleep(TestUtil.SLEEP_ONE_SECOND);
		bufferPool.getBufferFrame(PAGE_0.getPageId()).unpin(); //TouchCount: 4
		
		bufferPool.getBufferFrame(PAGE_2.getPageId()).pin();
		Thread.sleep(TestUtil.SLEEP_ONE_SECOND); 
		bufferPool.getBufferFrame(PAGE_2.getPageId()).unpin();
		Thread.sleep(TestUtil.SLEEP_ONE_SECOND); 
		bufferPool.getBufferFrame(PAGE_2.getPageId()).pin(); 
		Thread.sleep(TestUtil.SLEEP_ONE_SECOND); 
		bufferPool.getBufferFrame(PAGE_2.getPageId()).unpin(); //TouchCount: 4

		bufferPool.getBufferFrame(PAGE_1.getPageId()).pin(); 
		Thread.sleep(TestUtil.SLEEP_ONE_SECOND);
		bufferPool.getBufferFrame(PAGE_1.getPageId()).unpin(); //TouchCount: 2
		
		assertEquals(PAGE_1,bufferPool.findVictim(PAGE_3.getPageId()).getPage());
		assertEquals(1,((TouchCountBufferFrame)bufferPool.getBufferFrame(PAGE_0.getPageId())).getTouchCount()); //Page0 moved to Hot and Cold again should have TouchCount 1
		assertEquals(1,((TouchCountBufferFrame)bufferPool.getBufferFrame(PAGE_1.getPageId())).getTouchCount()); //Page1 moved to Cold should have TouchCount 1
		assertEquals(0,((TouchCountBufferFrame)bufferPool.getBufferFrame(PAGE_2.getPageId())).getTouchCount()); //Page2 moved to Hot should have TouchCount 0
		
		assertEquals(PAGE_1,bufferPool.findVictim(PAGE_3.getPageId()).getPage());
		
	}
	
	//hacer un test con 50% y 4 elementos
	
	@Test
	public void testMidPointerWithThirdHotPercentage() throws Exception
	{
		double oneThird = 34.0;
		int countIntervalSeconds = 1;
		int agingHotCriteria = 3; 
		bufferPool = new TouchCountBufferPool(POOL_MAX_SIZE , oneThird, new TouchCountReplacementStrategy(countIntervalSeconds, agingHotCriteria));
		
		assertEquals(0,((TouchCountBufferPool)bufferPool).getMidPointer());
		bufferPool.addNewPage(PAGE_0);
		assertEquals(1,((TouchCountBufferPool)bufferPool).getMidPointer());
		
		bufferPool.addNewPage(PAGE_1);
		assertEquals(2,((TouchCountBufferPool)bufferPool).getMidPointer());
		
		bufferPool.addNewPage(PAGE_2);
		assertEquals(2,((TouchCountBufferPool)bufferPool).getMidPointer());
		//In the list should be in this order: 0,2,1
		
		
	}
}
