package ubadb.external.bufferManagement;

import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import ubadb.core.common.TransactionId;
import ubadb.external.bufferManagement.etc.PageReference;
import ubadb.external.bufferManagement.etc.PageReferenceTrace;
import ubadb.external.bufferManagement.etc.PageReferenceTraceSerializer;
import ubadb.external.bufferManagement.etc.PageReferenceType;
import ubadb.external.bufferManagement.traceGenerators.BNLJTraceGenerator;
import ubadb.external.bufferManagement.traceGenerators.BufferPoolTraceGenerator;
import ubadb.external.bufferManagement.traceGenerators.FileScanTraceGenerator;
import ubadb.external.bufferManagement.traceGenerators.IndexScanTraceGenerator;
import ubadb.external.bufferManagement.traceGenerators.MixedTraceGenerator;


public class MainTraceGenerator
{
	public static void main(String[] args) throws Exception
	{
//		basicDataSet();
		//complexDataSet();
		//pathologicalDataSet();
		benchmarksDataSets();
	}

	private static void benchmarksDataSets() throws Exception
	{
		PageReferenceTraceSerializer serializer = new PageReferenceTraceSerializer();
		
		String smallQueriesAndBigFileScanPathological = "smallQueriesAndBigFileScanPathological1.trace";
		String fileNameLRU = "generated/" + smallQueriesAndBigFileScanPathological;
		
		int bigbufferSize = 400;
		PageReferenceTrace traceA1 = new BufferPoolTraceGenerator().generateReapeatedSmallQueriesWithBigFileScanPathological(bigbufferSize); 
		serialize(fileNameLRU, traceA1, serializer);
		
		String fileNameOneBidFileScan = "generated/smallQueriesAndOneBigFileScan1.trace";
		PageReferenceTrace trace2 = new BufferPoolTraceGenerator().generateReapeatedSmallQueriesWithOneBigFileScan(bigbufferSize);
		serialize(fileNameOneBidFileScan, trace2, serializer);
		
		String generateBadMRUAndNotGodLRU = "generated/badMRUAndNotGodLRU1.trace";
		int hotCriteria = 5;
		int mediumBufferPool = 200;
		PageReferenceTrace trace3 = new BufferPoolTraceGenerator().generateBadMRUAndNotGodLRU(mediumBufferPool,hotCriteria);
		serialize(generateBadMRUAndNotGodLRU, trace3, serializer);
		
		String generatePageBlast = "generated/pageBlast.trace";
		int blastBuffer = 50;
		int blastHits = 10;
		PageReferenceTrace trace4 = new BufferPoolTraceGenerator().generatePageBlast(blastBuffer, blastHits);
		serialize(generatePageBlast, trace4, serializer);
		
	}
	
	private static void pathologicalDataSet() throws Exception
	{
		PageReferenceTraceSerializer serializer = new PageReferenceTraceSerializer();
		
		int transactionId = 1;
		int bufferPoolLength = 10;
		int bufferPoolLengthLong = 100;
		int missCountAfterBufferFull = 10;
		String lruPathological = "lruPathological-Music.trace";
		String fileNameLRU = "generated/lruPathological-Music.trace";
		
		PageReferenceTrace traceA1 = new BufferPoolTraceGenerator().generateLRUPathologicalSet(transactionId, lruPathological, bufferPoolLength, missCountAfterBufferFull); 
		serialize(fileNameLRU, traceA1, serializer);
		
		String mruPathological = "mruPathological-Music.trace";
		String fileNameMRU = "generated/" + mruPathological;
		PageReferenceTrace traceA2 = new BufferPoolTraceGenerator().generateMRUPathologicalSet(transactionId, mruPathological, bufferPoolLength, missCountAfterBufferFull); 
		serialize(fileNameMRU, traceA2, serializer);
		
		String lruVSTouchCount = "lruVSTouchCount-Music.trace";
		String fileNameLRUTouch = "generated/" + lruVSTouchCount;
		int agingHotCriteria = 5;
		PageReferenceTrace traceA3 = new BufferPoolTraceGenerator().generateLRUAllMissVersusTouchCountAllHit(transactionId, lruVSTouchCount, bufferPoolLength, agingHotCriteria);
		serialize(fileNameLRUTouch, traceA3, serializer);
		
		String lruVSTouchCountLong = "lruVSTouchCountLong-Music.trace";
		String fileNameLRUTouchLong = "generated/" + lruVSTouchCountLong;
		PageReferenceTrace traceA4 = new BufferPoolTraceGenerator().generateLRUAllMissVersusTouchCountAllHit(transactionId, lruVSTouchCount, bufferPoolLengthLong, agingHotCriteria);
		serialize(fileNameLRUTouchLong, traceA4, serializer);
		
	}
	
	
	private static void basicDataSet() throws Exception
	{
		PageReferenceTraceSerializer serializer = new PageReferenceTraceSerializer();
		
		//File Scan
		String fileNameA1 = "generated/fileScan-Company.trace";
		PageReferenceTrace traceA1 = new FileScanTraceGenerator().generateFileScan(1, "Company", 10);
		serialize(fileNameA1, traceA1, serializer);
		
		String fileNameA2 = "generated/fileScan-Product.trace";
		PageReferenceTrace traceA2 = new FileScanTraceGenerator().generateFileScan(1, "Product", 100);
		serialize(fileNameA2, traceA2, serializer);
		
		String fileNameA3 = "generated/fileScan-Sale.trace";
		PageReferenceTrace traceA3 = new FileScanTraceGenerator().generateFileScan(1,"Sale", 1000);
		serialize(fileNameA3, traceA3, serializer);
		
		//Index Scan Clustered
		String fileNameB1 = "generated/indexScanClustered-Product.trace";
		PageReferenceTrace traceB1 = new IndexScanTraceGenerator().generateIndexScanClustered(1,"Product", 3, 10, 50);
		serialize(fileNameB1, traceB1, serializer);
		
		String fileNameB2 = "generated/indexScanClustered-Sale.trace";
		PageReferenceTrace traceB2 = new IndexScanTraceGenerator().generateIndexScanClustered(1,"Sale", 4, 200, 100);
		serialize(fileNameB2, traceB2, serializer);
		
		//Index Scan Unclustered
		String fileNameC1 = "generated/indexScanUnclustered-Product.trace";
		PageReferenceTrace traceC1 = new IndexScanTraceGenerator().generateIndexScanUnclusteredForASingleLeaf(1,"Product", 3, 40, 100);
		serialize(fileNameC1, traceC1, serializer);
		
		String fileNameC2 = "generated/indexScanUnclustered-Sale.trace";
		PageReferenceTrace traceC2 = new IndexScanTraceGenerator().generateIndexScanUnclusteredForASingleLeaf(1,"Sale", 4, 250, 1000);
		serialize(fileNameC2, traceC2, serializer);
		
		//BNLJ
		String fileNameD1 = "generated/BNLJ-ProductXSale-group_50.trace";
		PageReferenceTrace traceD1 = new BNLJTraceGenerator().generateBNLJ(1,"Product", 100, "Sale", 1000, 50);
		serialize(fileNameD1, traceD1, serializer);
		
		String fileNameD2 = "generated/BNLJ-ProductXSale-group_75.trace";
		PageReferenceTrace traceD2 = new BNLJTraceGenerator().generateBNLJ(1,"Product", 100, "Sale", 1000, 75);
		serialize(fileNameD2, traceD2, serializer);
		
		String fileNameD3 = "generated/BNLJ-ProductXSale-group_100.trace";
		PageReferenceTrace traceD3 = new BNLJTraceGenerator().generateBNLJ(1,"Product", 100, "Sale", 1000, 100);
		serialize(fileNameD3, traceD3, serializer);
		
		String fileNameD4 = "generated/BNLJ-SaleXProduct-group_100.trace";
		PageReferenceTrace traceD4 = new BNLJTraceGenerator().generateBNLJ(1,"Sale", 1000, "Product", 100, 100);
		serialize(fileNameD4, traceD4, serializer);

		String fileNameD5 = "generated/BNLJ-SaleXProduct-group_250.trace";
		PageReferenceTrace traceD5 = new BNLJTraceGenerator().generateBNLJ(1,"Sale", 1000, "Product", 100, 250);
		serialize(fileNameD5, traceD5, serializer);
	}
	
	private static void serialize(String fileName, PageReferenceTrace trace, PageReferenceTraceSerializer serializer) throws Exception
	{
		serializer.write(trace, fileName);
		System.out.println("File '" + fileName + "' generated!!");
	}
	
	private static void complexDataSet() throws Exception
	{
		PageReferenceTraceSerializer serializer = new PageReferenceTraceSerializer();
		String folderA = "generated/escenario3/originalesA";
		String fileA = "generated/mixedA_tot4_conc2.trace";
		mixTraces(fileA,folderA,4,2,serializer);

		String folderB = "generated/escenario3/originalesB";
		String fileB = "generated/mixedB_tot10_conc2.trace";
		mixTraces(fileB,folderB,10,2,serializer);

		String folderC = "generated/escenario3/originalesC";
		String fileC = "generated/mixedC_tot50_conc2.trace";
		mixTraces(fileC,folderC,50,2,serializer);

		String folderD = "generated/escenario3/originalesD";
		String fileD = "generated/mixedD_tot50_conc5.trace";
		mixTraces(fileD,folderD,50,5,serializer);

		String folderE = "generated/escenario3/originalesE";
		String fileE = "generated/mixedE_tot100_conc5.trace";
		mixTraces(fileE,folderE,100,5,serializer);
	}

	private static void mixTraces(String fileNameForNewTrace, String folderName, int totalTracesCount, int maxConcurrentTracesCount, PageReferenceTraceSerializer serializer) throws Exception
	{
		List<PageReferenceTrace> tracesToMix = buildTracesToMix(folderName,totalTracesCount,serializer);
		
		PageReferenceTrace mixedTrace = new MixedTraceGenerator().generateMixedTrace(tracesToMix, totalTracesCount, maxConcurrentTracesCount);
		
		serializer.write(mixedTrace, fileNameForNewTrace);
		System.out.println("File " + fileNameForNewTrace + " generated");
	}

	private static List<PageReferenceTrace> buildTracesToMix(String folderName, int totalTracesCount, PageReferenceTraceSerializer serializer) throws Exception
	{
		List<PageReferenceTrace> tracesToMix = new ArrayList<>();
		Random random = new Random(System.currentTimeMillis());
		
		String[] traceFiles = Paths.get(folderName).toFile().list();
		
		for(int i=0; i < totalTracesCount; i++)
		{
			int anyTraceIndex = random.nextInt(traceFiles.length); 
			PageReferenceTrace anyTrace = serializer.read(folderName + "/" + traceFiles[anyTraceIndex]);
			anyTrace.changeTransactionId(new TransactionId(i));
			
			tracesToMix.add(anyTrace);
		}
		
		return tracesToMix;
	}
}
