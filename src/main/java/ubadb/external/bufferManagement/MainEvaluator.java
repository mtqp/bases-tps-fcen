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
	private static int BUFFER_POOL_SIZE = 10;
	private static double SECONDS_PAUSE_BETWEEN_REFERENCES = 1.5;
	private static int AGING_HOT_CRITERIA = 5;
	private static int COUNT_INTERVAL_SECONDS = 1;
	private static final String LINE = "------------------------------";
	
	public static void main(String[] args)
	{
		try
		{
			/*
			processMRUPathological();
			System.out.println(LINE);
			processLRUPathological();
			System.out.println(LINE);
			processLRUVersusTouchCount();
			System.out.println(LINE);
			processLRUVersusTouchCountLong();*/
			System.out.println(LINE);
			processSmallQueriesAndOneBigFileScan();
			/*System.out.println(LINE);
			processSmallQueriesAndBigFileScansPathological();*/
		}
		catch(Exception e)
		{
			System.out.println("FATAL ERROR (" + e.getMessage() + ")");
			e.printStackTrace();
		}
	}

	/*
	 * Buffer de 400 items, todas consultas chiquitas un file scan grande, y de vuelta consultas chicas sobre las anteriores
	 * Notar que la mejora en el touch count no es linea conforme aumenta el porcentaje de hot
	 * Para este caso siempre es mejor que LRU
	 * 
	---SmallQueriesAndOneBigFileScans---
	---MRU---
	Hits: 6613
	Misses: 1659
	Hit rate: 0.7994439071566731
	---LRU---
	Hits: 6692
	Misses: 1580
	Hit rate: 0.8089941972920697
	---TouchCount (25% HOT)---
	Hits: 6792
	Misses: 1480
	Hit rate: 0.8210831721470019
	---TouchCount (50% HOT)---
	Hits: 6849
	Misses: 1423
	Hit rate: 0.8279738878143134
	---TouchCount (75% HOT)---
	Hits: 6907
	Misses: 1365
	Hit rate: 0.8349854932301741
	---TouchCount (90% HOT)---
	Hits: 6902
	Misses: 1370
	Hit rate: 0.8343810444874274
	*/
	private static void processSmallQueriesAndOneBigFileScan() throws Exception
	{
		String fileName = "generated/smallQueriesAndOneBigFileScan.trace";
		
		COUNT_INTERVAL_SECONDS = 0;
		BUFFER_POOL_SIZE = 400;
		AGING_HOT_CRITERIA = 10;
		SECONDS_PAUSE_BETWEEN_REFERENCES = 0.001;
		
		System.out.println("---SmallQueriesAndOneBigFileScans---");
		System.out.println("---MRU---");
		evaluateMRUReplacementStrategy(fileName);
		System.out.println("---LRU---");
		evaluateLRUReplacementStrategy(fileName);
		System.out.println("---TouchCount (25% HOT)---");
		evaluateTouchCountReplacementStrategy(fileName, COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, BUFFER_POOL_SIZE, 25);
		System.out.println("---TouchCount (50% HOT)---");
		evaluateTouchCountReplacementStrategy(fileName, COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, BUFFER_POOL_SIZE, 50);
		System.out.println("---TouchCount (75% HOT)---");
		evaluateTouchCountReplacementStrategy(fileName, COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, BUFFER_POOL_SIZE, 75);
		System.out.println("---TouchCount (90% HOT)---");
		evaluateTouchCountReplacementStrategy(fileName, COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, BUFFER_POOL_SIZE, 90);
	
		AGING_HOT_CRITERIA = 5;
		BUFFER_POOL_SIZE = 10;
		SECONDS_PAUSE_BETWEEN_REFERENCES = 1.5;
		COUNT_INTERVAL_SECONDS = 1;
	}
	
	/*
	 * Con estas variables resulto ser un caso horrible para LRU
	 * hacer alguno que no sea tan crudo para LRU
	 * Igual esta bueno ver que aunque haga un 25% mejora lo que LRU no puede mejorar
	 * 
	---SmallQueriesAndBigFileScansPathological--- (buffer de 300 items)
	---MRU---
	Hits: 13460
	Misses: 10656
	Hit rate: 0.5581356775584674
	---LRU---
	Hits: 0
	Misses: 24116
	Hit rate: 0.0
	---TouchCount (25% HOT)---
	Hits: 3626
	Misses: 20490
	Hit rate: 0.15035660971968817
	---TouchCount (50% HOT)---
	Hits: 7301
	Misses: 16815
	Hit rate: 0.3027450655166694
	---TouchCount (75% HOT)---
	Hits: 10976
	Misses: 13140
	Hit rate: 0.4551335213136507
	---TouchCount (90% HOT)---
	Hits: 13181
	Misses: 10935
	Hit rate: 0.5465665947918394
	*/
	private static void processSmallQueriesAndBigFileScansPathological() throws Exception
	{
		String fileName = "generated/smallQueriesAndBigFileScanPathological.trace";
		
		COUNT_INTERVAL_SECONDS = 0;
		BUFFER_POOL_SIZE = 300;
		AGING_HOT_CRITERIA = 10;
		SECONDS_PAUSE_BETWEEN_REFERENCES = 0.005;
		
		System.out.println("---SmallQueriesAndBigFileScans (pathological)---");
		System.out.println("---MRU---");
		evaluateMRUReplacementStrategy(fileName);
		System.out.println("---LRU---");
		evaluateLRUReplacementStrategy(fileName);
		System.out.println("---TouchCount (25% HOT)---");
		evaluateTouchCountReplacementStrategy(fileName, COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, BUFFER_POOL_SIZE, 25);
		System.out.println("---TouchCount (50% HOT)---");
		evaluateTouchCountReplacementStrategy(fileName, COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, BUFFER_POOL_SIZE, 50);
		System.out.println("---TouchCount (75% HOT)---");
		evaluateTouchCountReplacementStrategy(fileName, COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, BUFFER_POOL_SIZE, 75);
		System.out.println("---TouchCount (90% HOT)---");
		evaluateTouchCountReplacementStrategy(fileName, COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, BUFFER_POOL_SIZE, 90);
	
		AGING_HOT_CRITERIA = 5;
		BUFFER_POOL_SIZE = 10;
		SECONDS_PAUSE_BETWEEN_REFERENCES = 1.5;
		COUNT_INTERVAL_SECONDS = 1;
	}
	
	/*
	---LRU 50 misses, TouchCount 50 hits---
	---LRU---
	Hits: 200
	Misses: 300
	Hit rate: 0.4
	---TouchCount---
	Hits: 350
	Misses: 150
	Hit rate: 0.7
	*/
	private static void processLRUVersusTouchCountLong() throws Exception,
		InterruptedException, BufferManagerException {
		System.out.println("---LRU 50 misses, TouchCount 50 hits---");
		System.out.println("---LRU---");
		evaluateLRUReplacementStrategy("generated/lruVSTouchCountLong-Music.trace");
		System.out.println("---TouchCount---");
		evaluateTouchCountReplacementStrategy("generated/lruVSTouchCountLong-Music.trace", COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, 100);
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
		evaluateTouchCountReplacementStrategy("generated/lruVSTouchCount-Music.trace", COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, BUFFER_POOL_SIZE);
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
		evaluateTouchCountReplacementStrategy("generated/lruPathological-Music.trace", COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, BUFFER_POOL_SIZE);
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
		evaluateTouchCountReplacementStrategy("generated/mruPathological-Music.trace", COUNT_INTERVAL_SECONDS, AGING_HOT_CRITERIA, BUFFER_POOL_SIZE);
	}

		//TODO: validar que countIntervalSeconds no nos joda la vida y aging hot criteria

	private static void evaluateTouchCountReplacementStrategy(String traceFileName, int countIntervalSeconds, int agingHotCriteria, int poolSize) throws Exception,
	InterruptedException, BufferManagerException {
		int percentHotDefault = 50;
		evaluateTouchCountReplacementStrategy(traceFileName, countIntervalSeconds, agingHotCriteria, poolSize, percentHotDefault);
	}
	
	private static void evaluateTouchCountReplacementStrategy(String traceFileName, int countIntervalSeconds, int agingHotCriteria, int poolSize, int percentHot) throws Exception,
	InterruptedException, BufferManagerException {
		PageReplacementStrategy pageReplacementStrategy = new TouchCountReplacementStrategy(countIntervalSeconds, agingHotCriteria);
		int agingCoolCount = 1;
		BufferPool touchCountBufferPool = new TouchCountBufferPool(poolSize, percentHot, agingHotCriteria, agingCoolCount, pageReplacementStrategy);
		
		evaluate(pageReplacementStrategy, touchCountBufferPool, traceFileName, poolSize);
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
		
		int line = 0;
		
		for(PageReference pageReference : trace.getPageReferences())
		{
			//Pause references to have different dates in LRU and MRU
			Thread.sleep((int)(SECONDS_PAUSE_BETWEEN_REFERENCES * 1000));
			
			if(line % 500 == 0)
				System.out.print(line + " ");
			line++;
			
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
		
		System.out.println();
		
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
