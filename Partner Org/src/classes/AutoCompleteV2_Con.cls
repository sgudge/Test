public class AutoCompleteV2_Con {

    public String labelField{ get; set; }
    public String valueField{ get; set; }
    public String sObjVal{get;set;}
    public Integer randomJsIden{get;set;}
    public Object cacheField{get;private set;} 
    
    private Object targetFieldVar;
    
    public AutoCompleteV2_Con(){
        randomJsIden = getRandomNumber(1000000);
        sObjVal='Account';
        labelField='Name';
        valueField='Id';
    }
    
    /*Dummy setter Method*/
    public void setCacheField(Object cacheField){}
    
    public void setTargetFieldVar(Object targetFieldVar){
        
        if(targetFieldVar != this.targetFieldVar){
            cacheField = getCacheFieldValue(targetFieldVar);
            this.targetFieldVar = targetFieldVar;
           
        }
        
    }
    
    public Object getTargetFieldVar(){
        return targetFieldVar;
    }
    
    private Object getCacheFieldValue(Object targetFieldVar){
        Object retVal = targetFieldVar;
        system.debug('targetFieldVar::'+targetFieldVar);
        if(targetFieldVar!=null){
            for(sObject sObj : Database.query('SELECT '+valueField+','+labelField+' FROM '+sObjVal+' WHERE '+valueField+' =:targetFieldVar')){
                retVal = sObj.get(labelField);
                break;
            }
        }
        
        return retVal;
    }

    
    /*
    *Random number generator to change the js function name if multiple components us
    ***/
    private Integer getRandomNumber(Integer size){
        Double d = Math.random() * size;
        return d.intValue();
    }
    
    /*
    *This method queries data according to the passed parameters
    ***/
    @RemoteAction
    public static List<AutoCompleteData> getData(String sObjVal,String labelField,String valueField,String param){
       
        List<AutoCompleteData> AutoCompleteDatas = new List<AutoCompleteData>();
        param = String.escapeSingleQuotes(param);
        for( Sobject sObj : Database.query('SELECT '+valueField+','+labelField+' FROM '+sObjVal+' WHERE '+labelField+' LIKE \'%'+param+'%\'')){
            AutoCompleteDatas.add(new AutoCompleteData(sObj.get(valueField),sObj.get(labelField)));
        }
        
        return AutoCompleteDatas;
        
    }
    
    public class AutoCompleteData{
        public String id;
        public String text;
        
        public AutoCompleteData(Object id, Object text){
            this.id = String.valueOf(id);
            this.text = String.valueOf(text);
        }
    }

    
}