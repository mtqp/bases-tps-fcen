package ubadb.external.bufferManagement.traceGenerators;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.common.TransactionId;
import ubadb.external.bufferManagement.etc.PageReferenceTrace;

public class BufferPoolTraceGenerator extends PageReferenceTraceGenerator
{
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
	
	public PageReferenceTrace generateLRUPathologicalVersusAllsHitTouchCountSet(long transactionNumber, String fileName, int bufferPoolLength, int missCountAfterBufferFull, int agingHotCriteria)
	{
		/* [referencePages]
		 * Genera bufferPoolLength paginas distintas
		 * Esto obliga al bufferPool a que se llene
		 */
		List<PageId> referencePages = generateSequentialPages(fileName, 0, bufferPoolLength);
		
		/* [pages]
		 * Contiene las bufferPoolLength + 1 paginas utilizadas para ver el caso
		 * SIN REPETIDOS.
		 */
		List<PageId> pages = new ArrayList<PageId>(referencePages);
		
		int newPageId = bufferPoolLength;
		PageId overflowPage = new PageId(newPageId, new TableId(fileName));
		pages.add(overflowPage);
		
		int lruPageId = 0;
		int missCount = 0;
		while(missCount<missCountAfterBufferFull)
		{
			PageId lruPage = pages.get(lruPageId);
			setHotStateToPage(agingHotCriteria, referencePages, lruPage);

			/*
			 * Debe eliminar una pagina, como la pagina LRU tiene touchCount > agingHotCriteria
			 * la pasa a la zona Hot, en cambio LRU la desaloja
			 */
			referencePages.add(overflowPage);
			referencePages.add(lruPage);
			
			overflowPage = lruPage; //Cargo como la pagina que voy a necesitar a la que acabo de desalojar
			
			lruPageId++;
			lruPageId = lruPageId % pages.size();
			missCount++;
		}
		
		return buildRequestAndRelease(new TransactionId(transactionNumber), referencePages);
	}	
	
	private void setHotStateToPage(int agingHotCriteria, List<PageId> pages,
			PageId lruPage) {
		for(int i=0;i<agingHotCriteria;i++)
		{
			/*
			 * Referencio la pagina LRU para que este en condiciones
			 * subir a la hot area
			 */
			
			pages.add(lruPage);
		}
	}
}
