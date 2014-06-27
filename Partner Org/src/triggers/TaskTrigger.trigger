trigger TaskTrigger on Task (after insert, after update) {
	TriggerManager.invoke(TaskTriggerHandler.class); 
}