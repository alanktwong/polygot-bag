package org.awong.threads;


import junit.framework.TestCase;

import org.junit.Ignore;
import org.junit.Test;

public class AppTest extends TestCase {
	
	@Test
	public void testTest() {
		assertTrue(1 > 0);
	}
	
	@Ignore
	public void testTestFail() {
		assertEquals("testname2", "testname2");
	}
}
