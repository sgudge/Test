public class MyController {
   public String AccountName;
   
        public MyController() {
           system.debug('Constructor Called:::::'+datetime.now());
           List<Account>act =[Select Id, Name from Account LIMIT 1];
           AccountName = act[0].Name;
           
        }
       
        public void  save() {
            system.debug('AccountName ::::'+datetime.now()+'::::::::::'+AccountName );
            
        }
}