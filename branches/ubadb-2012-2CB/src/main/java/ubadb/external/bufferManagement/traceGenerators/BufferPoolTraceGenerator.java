package ubadb.external.bufferManagement.traceGenerators;

import java.util.ArrayList;
import java.util.List;

import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.common.TransactionId;
import ubadb.external.bufferManagement.etc.PageReferenceTrace;

public class BufferPoolTraceGenerator extends PageReferenceTraceGenerator
{
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
