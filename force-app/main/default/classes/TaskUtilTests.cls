@isTest
private class TaskUtilTests {
  
  // Test for 'Normal' priority
  @isTest
  static void testGetTaskPriorityNormal() {
    Test.startTest();
    String priority = TaskUtil.getTaskPriority('NY');
    System.assertEquals('Normal', priority, 'Expected priority should be Normal');
    Test.stopTest();
  }
  
  // Test for 'High' priority
  @isTest
  static void testGetTaskPriorityHigh() {
    Test.startTest();
    String priority = TaskUtil.getTaskPriority('CA');
    System.assertEquals('High', priority, 'Expected priority should be High');
    Test.stopTest();
  }
  
  // Test for null return when leadState is blank
  @isTest
  static void testGetTaskPriorityBlank() {
    Test.startTest();
    String priority = TaskUtil.getTaskPriority('');
    System.assertEquals(null, priority, 'Expected priority should be null');
    Test.stopTest();
  }
  
  // Test for null return when leadState length is greater than 2
  @isTest
  static void testGetTaskPriorityInvalidLength() {
    Test.startTest();
    String priority = TaskUtil.getTaskPriority('ABC');
    System.assertEquals(null, priority, 'Expected priority should be null');
    Test.stopTest();
  }
  
}