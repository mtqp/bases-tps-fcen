package ubadb.external.bufferManagement.traceGenerators;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.common.TransactionId;
import ubadb.external.bufferManagement.etc.PageReferenceTrace;

public class BufferPoolTraceGenerator extends PageReferenceTraceGenerator
{
	public PageReferenceTrace generateReapeatedSmallQueriesWithOneBigFileScan(int bufferPoolLength)
	{
		int upperRandomBound = bufferPoolLength;
		int hugeSelectCount = 2*(bufferPoolLength+(bufferPoolLength/10));
		int fivePercentSelectCount = (int) (0.05 * ((double)bufferPoolLength)); 
		int fifteenPercentSelectCount = (int) (0.15 * ((double)bufferPoolLength));
		int smallSelectCount = (int) (0.03 * ((double)bufferPoolLength));;
		
		List<PageId> pagesSelectMusic = selectConsecutivesPages(fivePercentSelectCount , "Music");
		List<PageId> pagesArtists = selectConsecutivesPages(fivePercentSelectCount , "Artist");
		List<PageId> pagesRecordCompanies = selectConsecutivesPages(fifteenPercentSelectCount, "Label");
		List<PageId> bigFileScan = selectConsecutivesPages(hugeSelectCount, "Genre");
		
		List<PageId> transaction = new ArrayList<>();
		
		int iterations = bufferPoolLength / 6;
		
		for(int i=0;i<iterations;i++)
		{
			List<PageId> smallPagesArtists = selectRandomPages(smallSelectCount, "CountrySales", upperRandomBound);
			
			List<List<PageId>> allLoopItems = new ArrayList<List<PageId>>();
			
			allLoopItems.add(smallPagesArtists);
			allLoopItems.add(pagesSelectMusic);
			allLoopItems.add(pagesArtists);
			allLoopItems.add(pagesRecordCompanies);
			
			transaction.addAll(randomizeAndFlatten(allLoopItems));
			
			if(i == (iterations/2))
				transaction.addAll(bigFileScan);
			
		}
		
		return buildRequestAndRelease(new TransactionId(1), transaction);
	}
	

	private List<PageId> randomizeAndFlatten(List<List<PageId>> items)
	{
		List<PageId> flattenItems = new ArrayList<PageId>();
		
		Random rand = new Random();
		
		while(!items.isEmpty())
		{
			int randIndex = rand.nextInt(items.size());
			flattenItems.addAll(items.get(randIndex));
			items.remove(randIndex);
		}
		
		return flattenItems;
	}
	
	public PageReferenceTrace generateReapeatedSmallQueriesWithBigFileScanPathological(int bufferPoolLength)
	{
		int smallQueriesWeight = 50;
		
		int upperRandomBound = bufferPoolLength;
		int hugeSelectCount = bufferPoolLength + (bufferPoolLength/3);
		int fiftyPercentSelectCount = (int) (0.5 * ((double)bufferPoolLength)); 
		int fifteenPercentSelectCount = (int) (0.15 * ((double)bufferPoolLength));
		int smallestSelectCount = 1;
		
		List<PageId> pagesSelectMusic = selectConsecutivesPages(fiftyPercentSelectCount , "Music");
		List<PageId> pagesArtists = selectConsecutivesPages(fiftyPercentSelectCount , "Artist");
		List<PageId> pagesRecordCompanies = selectConsecutivesPages(fifteenPercentSelectCount, "Label");
		List<PageId> bigFileScan = selectConsecutivesPages(hugeSelectCount, "Genre");
		
		List<PageId> transaction = new ArrayList<>();
		
		/*
		 * Cargo con mucho peso las consultas liviana
		 * En touch count el peso las va a salvar
		 * En LRU y MRU no
		 */
		for(int i=0;i<smallQueriesWeight;i++)
		{
			List<PageId> smallPagesArtists = selectRandomPages(smallestSelectCount, "CountrySales", upperRandomBound);
			
			transaction.addAll(smallPagesArtists);
			transaction.addAll(pagesSelectMusic);
			transaction.addAll(pagesArtists);
			transaction.addAll(pagesRecordCompanies);
			
			if(i == (smallQueriesWeight/5) || i == (smallQueriesWeight/2))
				transaction.addAll(bigFileScan);
			
		}
		
		return buildRequestAndRelease(new TransactionId(1), transaction);
	}
	
	private List<PageId> selectRandomPages(int count, String table, int upperRandomBound)
	{
		Random rand = new Random();
		
		List<PageId> pages = new ArrayList<>();
		
		for(int i=0;i<count;i++)
		{
			int randomPageId = rand.nextInt(upperRandomBound);
			pages.add(new PageId(randomPageId, new TableId(table)));
		}
		
		return pages;
	}
	
	private List<PageId> selectConsecutivesPages(int count, String table)
	{
		List<PageId> pages = generateSequentialPages(table, 0, count);
		return pages;
	}
	
	/*[Objetivo del trace]
	 * Ver que al intercambiar entre la mas nueva y una que no esta en el buffer siempre
	 * se obtiene un miss
	 */
	public PageReferenceTrace generateMRUPathologicalSet(long transactionNumber, String fileName, int bufferPoolLength, int missCountAfterBufferFull)
	{
		/*
		 * Genera bufferPoolLength paginas distintas
		 * Esto obliga al bufferPool a que se llene
		 */
		List<PageId> pages = generateSequentialPages(fileName, 0, bufferPoolLength);
		
		int newPageId = bufferPoolLength;
		PageId newPage = new PageId(newPageId, new TableId(fileName));
		PageId mruPage = pages.get(pages.size()-1);
		
		int missCount = 0;
		
		while(missCount<missCountAfterBufferFull)
		{
			// Produce dos miss por cada iteracion del while (en el algoritmo de MRU)
			
			// Fuerza a que el algoritmo deba desalojar a la pagina MRU
			pages.add(newPage);
			
			missCount ++;
			
			if(missCount<missCountAfterBufferFull)
			{
				// newPage ahora debe ser desalojada para poder agregar a la mruPage, la cual fue desalojada en el paso anterior
				pages.add(mruPage);
				missCount++;
			}
		}
		
		return buildRequestAndRelease(new TransactionId(transactionNumber), pages);
	}
	
	/*[Objetivo del trace]
	 * Ver que al pedir siempre la pagina mas vieja en el buffer pool, el algoritmo
	 * siempre obtendra un miss
	 */
	public PageReferenceTrace generateLRUPathologicalSet(long transactionNumber, String fileName, int bufferPoolLength, int missCountAfterBufferFull)
	{
		/*
		 * Genera bufferPoolLength paginas distintas
		 * Esto obliga al bufferPool a que se llene
		 */
		List<PageId> pages = generateSequentialPages(fileName, 0, bufferPoolLength);
		
		int missCount = 0;
		if(missCount<missCountAfterBufferFull)
		{
			/*
			 * Fuerza el desalojo de la pagina menos recientemente usada, 
			 * que se encuentra al comienzo de la lista
			 */
			int newPageId = bufferPoolLength;
			PageId newPage = new PageId(newPageId, new TableId(fileName));
			pages.add(newPage);
			
			missCount++;
			
			int i=0;
			while(missCount<missCountAfterBufferFull)
			{
				/*
				 * En cada iteracion del while pido la pagina que acabo de desalojar
				 */
				pages.add(pages.get(i));
				i++;
				i = i % (bufferPoolLength+1); //el mas uno es xq lo estamos pensando a la lista de bufferPoolLength mas newPageId
				missCount++;
			}
		}
		
		return buildRequestAndRelease(new TransactionId(transactionNumber), pages);
	}

	//TODO: ojo que el pin y el unpin aumenta el touch count, hay que ver que pasa con el agingHotCriteria
	//cuando esta en 2...
	
	//TODO:ojo que puede no aumentar el touch count por los tres putos miliseconds
	
	/* [Objetivo del trace]
	 * Mostrar que el peso en cantidad de requests de una pagina hace que el touch count mantenga esas paginas en la cache
	 * mientras que LRU no las mantiene por no haber sido las ultimas referenciadas (Pesos vs. Tiempo de referencia)
	 */
	public PageReferenceTrace generateLRUAllMissVersusTouchCountAllHit(long transactionNumber, String fileName, int bufferPoolLength, int agingHotCriteria)
	{
		if(bufferPoolLength % 2 != 0 || agingHotCriteria <= 4)
			return null;
		
		/* [referencePages]
		 * Genera bufferPoolLength paginas distintas
		 * Esto obliga al bufferPool a que se llene
		 */
		List<PageId> pages = generateSequentialPages(fileName, 0, bufferPoolLength);
		List<PageId> referencePages = new ArrayList<PageId>();
		
		for(int i=0;i<pages.size();i++)
		{
			PageId page = pages.get(i);
			referenceNTimes(referencePages, page, 1);
		}
		
		for(int i=0;i<pages.size();i=i+2)
		{
			PageId page = pages.get(i);
			referenceNTimes(referencePages, page, agingHotCriteria);
		}
		
		for(int i=1;i<pages.size();i=i+2)
		{
			PageId page = pages.get(i);
			referenceNTimes(referencePages, page, 1);
		}
		
		/* Luego de los 3 fors anteriores el orden de los elementos en las listas son
		 * TouchCount = [0,2,4,6,8,9,7,5,3,1]
		 * LRU = [0,1,2,3,4,5,6,7,8,9]
		 */

		List<PageId> overflowsPages = generateSequentialPages(fileName, bufferPoolLength, bufferPoolLength + (bufferPoolLength/2));
		referencePages.addAll(overflowsPages);
		
		/*
		 * Pido las paginas pares, TouchCount debe dar Hit en todas,
		 * LRU miss en todas.
		 */
		for(int i=0;i<pages.size();i=i+2)
		{
			PageId page = pages.get(i);
			referenceNTimes(referencePages, page, 1);
		}
		
		return buildRequestAndRelease(new TransactionId(transactionNumber), referencePages);
	}
	
	private void referenceNTimes(List<PageId> references, PageId page, int nTimes)
	{
		for(int i=0;i<nTimes;i++)
			references.add(page);
	}
}
