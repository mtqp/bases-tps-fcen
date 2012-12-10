package ConsoleOut;

import java.util.Collection;

import ubadb.core.common.Page;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.ReferenceBufferFrame;

public class ConsoleOut {

	private static final boolean SHOW_CONSOLE_OUT = false; 
	
	private ConsoleOut(){}
	
	public static final void printReferenceFramesAndVictim(BufferFrame victim, Collection<BufferFrame> allFrames)
	{
		if(SHOW_CONSOLE_OUT){
			System.out.println("--------------------------------------------");
			ConsoleOut.victim(victim.getPage());
			
			for(BufferFrame frame : allFrames)
			{
				ReferenceBufferFrame referenced = (ReferenceBufferFrame) frame;
				System.out.println("Page: " + referenced.getPage().getPageId().getNumber() + " -|- referenced: " + referenced.getReferenceDate());
			}
			
			System.out.println("--------------------------------------------");
		}
	}
	
	public static final void victim(Page victim)
	{
		if(SHOW_CONSOLE_OUT)
			System.out.println("Victim page: " + victim.getPageId().getNumber());
	}
	
	public static final void pageRemoved(Page page)
	{
		if(SHOW_CONSOLE_OUT)
			System.out.println("Buffer full, page " + page.getPageId().getNumber() + " removed");
	}

	public static final void pageAdded(Page page)
	{
		if(SHOW_CONSOLE_OUT)
			System.out.println("Add page " + page.getPageId().getNumber());
	}
	
}
