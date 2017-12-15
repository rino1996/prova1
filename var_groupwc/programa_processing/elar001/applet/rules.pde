class Rule {
  
   Rule() {
   
   
   
   if (contador_borrar==0) { //despois elmininar este if agora imos so facer probas
     contador_borrar++;
     
     println("vamos coa regras");
     
     if ( msql.connect() )
      {
        //CONFIGURATION
        msql.query( "SELECT * FROM rules" );
        
        while (msql.next()) {
          int id_rule=msql.getInt("id_rule");
          println("id_rule: "+id_rule);
          println("name: "+msql.getString("name"));
          println("name: "+msql.getString("description"));
          
           //entonces comprobamos si ten accions
           msql.query( "SELECT * FROM conditions WHERE id_rule="+id_rule );
           
           //por defecto a regra non se cumpre
           int make_rule=0;
           int stop=0;
           while (msql.next()) {
             
             int id_device=msql.getInt("id_device");
             int operator=msql.getInt("operator");
             float value=msql.getFloat("value");
             println("id_condition: "+msql.getInt("id_condition"));
             println("id_device: "+id_device);
             println("operator: "+operator);
             println("value: "+value);
             
             //recollemos o valor actual do sensor que nos mande
             msql.query( "SELECT default_value FROM devices WHERE id_device="+id_device );
             int default_value=0;
             if (msql.next()) {
              default_value=msql.getInt("default_value");
              println(default_value);
             } else {
              stop=1;
             } 
            
             
             switch (operator) {
              case 0:
                 println("Maior");
                 if (stop==0 && default_value>value) {
                   println("vamos");
                 }
                      
              break;
              default:
                println("Algo malo pasou");
              break; 
             }
             
           }  
        }
       
    } 
 
      
   }
   
   }
   
   
  
}
