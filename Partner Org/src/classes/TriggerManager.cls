/**
* @author        Santosh Gudge (santosh@comitydesigns.com)
* @company       Comity Designs
* @date          05/15/2014          
* @description   Generic Manager to dispatch trigger execution flow
*/
public class TriggerManager {
    public interface ITriggerHandler { 
        // void onBeforeInsert(List<sObject> newRecords);
    
        // void onBeforeUpdate(List<SObject> oldRecords, List<SObject> newRecords, Map<ID, SObject> oldRecordsMap, Map<ID, SObject> newRecordsMap);
        
        // void onBeforeDelete(List<sObject> oldRecords, Map<ID, sObject> oldRecordsMap);
        
        void onAfterInsert(List<sObject> newRecords, Map<ID, sObject> newRecordsMap);
        
        // void onAfterUpdate(List<sObject> oldRecords, List<sObject> newRecords, Map<ID, sObject> oldRecordsMap, Map<ID, sObject> newRecordsMap);
        
        // void onAfterDelete(List<sObject> oldRecords, Map<ID, sObject> oldRecordsMap);
    }             
    
    public abstract class TriggerHandler implements ITriggerHandler {
    	
        // public virtual void onBeforeInsert(List<sObject> newRecords) {}
    
        // public virtual void onBeforeUpdate(List<SObject> oldRecords, List<SObject> newRecords, Map<ID, SObject> oldRecordsMap, Map<ID, SObject> newRecordsMap) {}
        
        // public virtual void onBeforeDelete(List<sObject> oldRecords, Map<ID, sObject> oldRecordsMap) {}
        
         public virtual void onAfterInsert(List<sObject> newRecords, Map<ID, sObject> newRecordsMap) {}
        
        // public virtual void onAfterUpdate(List<sObject> oldRecords, List<sObject> newRecords, Map<ID, sObject> oldRecordsMap, Map<ID, sObject> newRecordsMap) {}
        
        //public virtual void onAfterDelete(List<sObject> oldRecords, Map<ID, sObject> oldRecordsMap) {}
    
        private void invoke(
                Boolean isBefore, Boolean isAfter, Boolean isInsert, Boolean isUpdate, Boolean isDelete, 
                List<SObject> oldRecords, List<SObject> newRecords, Map<ID, SObject> oldRecordsMap, Map<ID, SObject> newRecordsMap) {
                
            if(isBefore) {
                if (isInsert) {
                	//onBeforeInsert(newRecords);
                }
                else if (isUpdate) {
                	// onBeforeUpdate(oldRecords, newRecords, oldRecordsMap, newRecordsMap);
                } 
                else if (isDelete) {
                	// onBeforeDelete(oldRecords, oldRecordsMap);
                }  
            }
            else {
                if (isInsert) {
                		onAfterInsert(newRecords, newRecordsMap);
                	//	else if (isUpdate) onAfterUpdate(oldRecords, newRecords, oldRecordsMap, newRecordsMap);
                	//	else if (isDelete) onAfterDelete(oldRecords, oldRecordsMap);
                }
            }
        }
    }
    
    /**
    * @author        
    * @date         
    * @description  Invoke trigger handler by type Usage: in trigger make call like  TriggerManager.invoke(ContactTriggerhandler.class);
    */
    public static void invoke(Type type) {
        Object handler = type.newInstance();
        system.debug('handler::'+handler);
        if (handler instanceof TriggerHandler) {
            invoke((TriggerHandler) handler);
        }
        else {            
            system.debug(LoggingLevel.ERROR, type + ' type doesn\'t extend TriggerHandler class');
        }        
    }
    
    /**
    * @author        
    * @date         
    * @description  Invoke trigger handler by existing instance. 
    * 				Usage: in trigger make call like  TriggerManager.invoke(new ContactTriggerhandler());
    */
    public static void invoke(TriggerHandler handler) {
        handler.invoke(
            Trigger.isBefore, 
            Trigger.isAfter, 
            Trigger.isInsert, 
            Trigger.isUpdate, 
            Trigger.isDelete,
            Trigger.old, 
            Trigger.new, 
            Trigger.oldMap,
            Trigger.newMap);
    }
}