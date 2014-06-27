public with sharing class TaskTriggerHandler extends TriggerManager.TriggerHandler {
	  public override void onAfterInsert(List<sObject> newRecords, Map<ID, sObject> newRecordsMap) {
		afterInsert((List<Task>)newRecords);  
	  }
	   private void afterInsert(List<Task> taskList){
	   	  system.debug('insuranceCaseList::'+taskList);
	   }
}