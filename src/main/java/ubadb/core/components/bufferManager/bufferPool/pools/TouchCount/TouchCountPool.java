package ubadb.core.components.bufferManager.bufferPool.pools.TouchCount;

import java.util.ArrayList;
import java.util.List;
import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.exceptions.BufferPoolException;

/**
 * A single buffer pool shared by all tables
 * 
 */
public class TouchCountPool implements BufferPool {

	private List<BufferFrame> framesPool;
	private PageReplacementStrategy pageReplacementStrategy;
	private int midPoint;
	private final int maxBufferPoolSize;

	public TouchCountPool(int maxBufferPoolSize,
			PageReplacementStrategy pageReplacementStrategy) {
		this.maxBufferPoolSize = maxBufferPoolSize;
		this.pageReplacementStrategy = pageReplacementStrategy;
		this.framesPool = new ArrayList<BufferFrame>();
	}

	public boolean isPageInPool(PageId pageId) {
		for (BufferFrame current : this.framesPool) {
			if (current.getPage().getPageId().equals(pageId))
				return true;
		}

		return false;
	}

	private BufferFrame findBufferInPool(PageId pageId) {
		for (BufferFrame current : this.framesPool) {
			if (current.getPage().getPageId().equals(pageId))
				return current;
		}

		return null;
	}

	public BufferFrame getBufferFrame(PageId pageId) throws BufferPoolException {
		if (isPageInPool(pageId))
			return findBufferInPool(pageId);
		else
			throw new BufferPoolException(
					"The requested page is not in the pool");
	}

	public boolean hasSpace(PageId pageToAddId) {
		return countPagesInPool() < maxBufferPoolSize;
	}

	public BufferFrame addNewPage(Page page) throws BufferPoolException {
		if (!hasSpace(page.getPageId()))
			throw new BufferPoolException("No space in pool for new page");
		else if (isPageInPool(page.getPageId()))
			throw new BufferPoolException("Page already exists in the pool");
		else {
			BufferFrame bufferFrame = pageReplacementStrategy
					.createNewFrame(page);
			this.framesPool.add(midPoint, bufferFrame);
			this.reloadMiddlePointer();
			// resetear a cero los que se movieron!
			return bufferFrame;
		}
	}

	private void reloadMiddlePointer() {
		double value = (double) this.framesPool.size() / (double) 2;
		this.midPoint = (int) Math.ceil(value);
	}

	public void removePage(PageId pageId) throws BufferPoolException {
		if (isPageInPool(pageId)) {
			BufferFrame frame = findBufferInPool(pageId);
			this.framesPool.remove(frame);
			this.reloadMiddlePointer();
		} else
			throw new BufferPoolException("Cannot remove an unexisting page");
	}

	public BufferFrame findVictim(PageId pageIdToBeAdded)
			throws BufferPoolException {
		try {
			return pageReplacementStrategy.findVictim(this.framesPool);
		} catch (Exception e) {
			throw new BufferPoolException(
					"Cannot find a victim page for removal", e);
		}
	}

	public int countPagesInPool() {
		return this.framesPool.size();
	}
}
