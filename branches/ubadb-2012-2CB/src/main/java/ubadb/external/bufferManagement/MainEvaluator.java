package ubadb.external.bufferManagement;

import ubadb.core.components.bufferManager.BufferManager;
import ubadb.core.components.bufferManager.BufferManagerImpl;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.pools.TouchCount.TouchCountBufferPool;
import ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.LRU.LRUReplacementStrategy;
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
	private static final int PAUSE_BETWEEN_REFERENCES	= 0;
	
	public static void main(String[] args)
	{
		try
		{
			//evaluateLRUReplacementStrategy("generated/lruVSTouchCount-Music.trace");
			evaluateTouchCountReplacementStrategy("generated/lruVSTouchCount-Music.trace", 1, 4);
		}
		catch(Exception e)
		{
			System.out.println("FATAL ERROR (" + e.getMessage() + ")");
			e.printStackTrace();
		}
	}

		//TODO: validar que countIntervalSeconds no nos joda la vida y aging hot criteria
	private static void evaluateTouchCountReplacementStrategy(String traceFileName, int countIntervalSeconds, int agingHotCriteria) throws Exception,
	InterruptedException, BufferManagerException {
		
	PageReplacementStrategy pageReplacementStrategy = new TouchCountReplacementStrategy(countIntervalSeconds, agingHotCriteria);
	int bufferPoolSize = 100;
	int percentHotDefault = 50;
	int agingCoolCount = 1;
	BufferPool touchCountBufferPool = new TouchCountBufferPool(bufferPoolSize, percentHotDefault, agingHotCriteria, agingCoolCount, pageReplacementStrategy);
	
	evaluate(pageReplacementStrategy, touchCountBufferPool, traceFileName, bufferPoolSize);
}
	
	private static void evaluateLRUReplacementStrategy(String traceFileName) throws Exception,
		InterruptedException, BufferManagerException {
		PageReplacementStrategy pageReplacementStrategy = new LRUReplacementStrategy();
		int bufferPoolSize = 100;
		
		evaluate(pageReplacementStrategy, traceFileName, bufferPoolSize);
	}
	
	private static void evaluateFIFOReplacementStrategy(String traceFileName) throws Exception,
			InterruptedException, BufferManagerException {
		PageReplacementStrategy pageReplacementStrategy = new FIFOReplacementStrategy();
		int bufferPoolSize = 100;
		
		evaluate(pageReplacementStrategy, traceFileName, bufferPoolSize);
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
			Thread.sleep(PAUSE_BETWEEN_REFERENCES);
			
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
