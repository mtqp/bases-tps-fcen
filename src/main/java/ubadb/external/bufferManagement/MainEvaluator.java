package ubadb.external.bufferManagement;

import ubadb.core.components.bufferManager.BufferManager;
import ubadb.core.components.bufferManager.BufferManagerImpl;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.pools.TouchCount.TouchCountBufferPool;
import ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.LRU.LRUReplacementStrategy;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.MRU.MRUReplacementStrategy;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.TouchCount.TouchCountReplacementStrategy;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.fifo.FIFOReplacementStrategy;
import ubadb.core.components.catalogManager.CatalogManager;
import ubadb.core.components.catalogManager.CatalogManagerImpl;
import ubadb.core.components.diskManager.DiskManager;
import ubadb.core.exceptions.BufferManagerException;
import ubadb.external.bufferManagement.etc.BufferManagementMetrics;
import ubadb.external.bufferManagement.etc.FaultCounterDiskManagerSpy;
import ubadb.external.bufferManagement.etc.PageReference;
import ubadb.external.bufferManagement.etc.PageReferenceTrace;
import ubadb.external.bufferManagement.etc.PageReferenceTraceSerializer;

public class MainEvaluator
{
	private static final int BUFFER_POOL_SIZE = 10;
	private static final double SECONDS_PAUSE_BETWEEN_REFERENCES = 1.5;
	private static final int AGING_HOT_CRITERIA = 5;
	private static final int COUNT_INTERVAL_SECONDS = 1;
	private static final String LINE = "------------------------------";
	
	public static void main(String[] args)
	{
		try
		{
			processMRUPathological();
			System.out.println(LINE);
			processLRUPathological();
			System.out.println(LINE);
			processLRUVersusTouchCount();
		}
		catch(Exception e)
		{
			System.out.println("FATAL ERROR (" + e.getMessage() + ")");
			e.printStackTrace();
		}
	}

	/*
	---LRU 5 misses, TouchCount 5 hits---
	---LRU---
	Hits: 30
	Misses: 20
	Hit rate: 0.6
	---TouchCount---
	Hits: 35
	Misses: 15
	Hit rate: 0.7
	 */
	private static void processLRUVersusTouchCount() throws Exception,
			InterruptedException, BufferManagerException {
		System.out.println("---LRU 5 misses, TouchCount 5 hits---");
		System.out.println("---LRU---");
		evaluateLRUReplacementStrategy("generated/lruVSTouchCount-Music.trace");
		System.out.println("---TouchCount---");
		evaluateTouchCountReplacementStrategy("generated/lruVSTouchCount-Music.trace", COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA);
	}

	/*
	---LRU Pathological---
	---MRU---
	Hits: 9
	Misses: 11
	Hit rate: 0.45
	---LRU---
	Hits: 0
	Misses: 20
	Hit rate: 0.0
	---TouchCount---
	Hits: 4
	Misses: 16
	Hit rate: 0.2
	*/
	private static void processLRUPathological() throws Exception,
			InterruptedException, BufferManagerException {
		System.out.println("---LRU Pathological---");
		System.out.println("---MRU---");
		evaluateMRUReplacementStrategy("generated/lruPathological-Music.trace");
		System.out.println("---LRU---");
		evaluateLRUReplacementStrategy("generated/lruPathological-Music.trace");
		System.out.println("---TouchCount---");
		evaluateTouchCountReplacementStrategy("generated/lruPathological-Music.trace", COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA);
	}

	/*
	---MRU Pathological---
	---MRU---
	Hits: 0
	Misses: 20
	Hit rate: 0.0
	---LRU---
	Hits: 9
	Misses: 11
	Hit rate: 0.45
	---TouchCount---
	Hits: 9
	Misses: 11
	Hit rate: 0.45
	*/
	private static void processMRUPathological() throws Exception,
			InterruptedException, BufferManagerException {
		System.out.println("---MRU Pathological---");
		System.out.println("---MRU---");
		evaluateMRUReplacementStrategy("generated/mruPathological-Music.trace");
		System.out.println("---LRU---");
		evaluateLRUReplacementStrategy("generated/mruPathological-Music.trace");
		System.out.println("---TouchCount---");
		evaluateTouchCountReplacementStrategy("generated/mruPathological-Music.trace", COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA);
	}

		//TODO: validar que countIntervalSeconds no nos joda la vida y aging hot criteria
	private static void evaluateTouchCountReplacementStrategy(String traceFileName, int countIntervalSeconds, int agingHotCriteria) throws Exception,
	InterruptedException, BufferManagerException {
		
		PageReplacementStrategy pageReplacementStrategy = new TouchCountReplacementStrategy(countIntervalSeconds, agingHotCriteria);
		int percentHotDefault = 50;
		int agingCoolCount = 1;
		BufferPool touchCountBufferPool = new TouchCountBufferPool(BUFFER_POOL_SIZE, percentHotDefault, agingHotCriteria, agingCoolCount, pageReplacementStrategy);
		
		evaluate(pageReplacementStrategy, touchCountBufferPool, traceFileName, BUFFER_POOL_SIZE);
	}
	
	private static void evaluateLRUReplacementStrategy(String traceFileName) throws Exception,
		InterruptedException, BufferManagerException {
		PageReplacementStrategy pageReplacementStrategy = new LRUReplacementStrategy();
		
		evaluate(pageReplacementStrategy, traceFileName, BUFFER_POOL_SIZE);
	}
	
	private static void evaluateMRUReplacementStrategy(String traceFileName) throws Exception,
	InterruptedException, BufferManagerException {
	PageReplacementStrategy pageReplacementStrategy = new MRUReplacementStrategy();
	
	evaluate(pageReplacementStrategy, traceFileName, BUFFER_POOL_SIZE);
}
	
	private static void evaluateFIFOReplacementStrategy(String traceFileName) throws Exception,
			InterruptedException, BufferManagerException {
		PageReplacementStrategy pageReplacementStrategy = new FIFOReplacementStrategy();
		
		evaluate(pageReplacementStrategy, traceFileName, BUFFER_POOL_SIZE);
	}

	private static void evaluate(PageReplacementStrategy pageReplacementStrategy, String traceFileName, int bufferPoolSize) throws Exception, InterruptedException, BufferManagerException
	{
		evaluate(pageReplacementStrategy, null, traceFileName, bufferPoolSize);
	}
	
	private static void evaluate(PageReplacementStrategy pageReplacementStrategy, BufferPool bufferPool, String traceFileName, int bufferPoolSize) throws Exception, InterruptedException, BufferManagerException
	{
		FaultCounterDiskManagerSpy faultCounterDiskManagerSpy = new FaultCounterDiskManagerSpy();
		CatalogManager catalogManager = new CatalogManagerImpl();
		BufferManager bufferManager = createBufferManager(faultCounterDiskManagerSpy, catalogManager, pageReplacementStrategy, bufferPool, bufferPoolSize);
		PageReferenceTrace trace = getTrace(traceFileName);
		
		for(PageReference pageReference : trace.getPageReferences())
		{
			//Pause references to have different dates in LRU and MRU
			Thread.sleep((int)(SECONDS_PAUSE_BETWEEN_REFERENCES * 1000));
			
			switch(pageReference.getType())
			{
				case REQUEST:
				{
					try
					{
						bufferManager.readPage(pageReference.getPageId());
					}
					catch(BufferManagerException e)
					{
						System.out.println("NO MORE SPACE AVAILABLE, MEMORY FULL");
						throw e;
					}
					break;
				}
				case RELEASE:
				{
					bufferManager.releasePage(pageReference.getPageId());
					break;
				}
			}
		}
		
		BufferManagementMetrics metrics = new BufferManagementMetrics(trace, faultCounterDiskManagerSpy.getFaultsCount());
		metrics.showSummary();
	}

	private static PageReferenceTrace getTrace(String traceFileName) throws Exception
	{
		PageReferenceTraceSerializer serializer = new PageReferenceTraceSerializer();
		return serializer.read(traceFileName);
	}

	private static BufferManager createBufferManager(DiskManager diskManager, CatalogManager catalogManager, PageReplacementStrategy pageReplacementStrategy, BufferPool bufferPool, int bufferPoolSize)
	{
		if(bufferPool == null)
			bufferPool = new SingleBufferPool(bufferPoolSize, pageReplacementStrategy);
		BufferManager bufferManager = new BufferManagerImpl(diskManager, catalogManager, bufferPool);
		
		return bufferManager;
	}
}
