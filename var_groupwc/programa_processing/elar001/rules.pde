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
           
           //por defecto a regra se cumpre
           int make_rule=1;
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
              make_rule=0;
             } 
            
             // Chuleta
             /*
             0: ==
             1: >=
             2: <=
             3: > 
             4: <
             5: !=
             */
             switch (operator) {
              case 0:
                 println("Igual");
                 if (make_rule==1 && default_value==value) {
                   println("Se cumple que e igual");
                 } else {
                   make_rule=0; 
                 }
              break;
              case 1:
                 println("Maior Igual");
                 if (make_rule==1 && default_value>=value) {
                   println("Se cumple que e maior igual");
                 } else {
                   make_rule=0; 
                 }
              break;
              case 2:
                 println("Menor Igual");
                 if (make_rule==1 && default_value<=value) {
                   println("Se cumple que e menor igual");
                 } else {
                   make_rule=0; 
                 }
              break;
              case 3:
                 println("Maior");
                 if (make_rule==1 && default_value>value) {
                   println("Se cumple que e maior");
                 } else {
                   make_rule=0; 
                 }
              break;
              case 4:
                 println("Menor");
                 if (make_rule==1 && default_value<value) {
                   println("Se cumple que e menor");
                 } else {
                   make_rule=0; 
                 }
              break;
              case 5:
                 println("Non Igual");
                 if (make_rule==1 && default_value!=value) {
                   println("Se cumple que e non igual");
                 } else {
                   make_rule=0; 
                 }
              break;
              default:
                println("Algo malo pasou");
              break; 
             }
             
           }  //fin do while das condicions
           
           if (make_rule==1) { //si se cumple a regra

                println("A regra cumpre as condicions");
                msql.query( "SELECT * FROM actions WHERE id_rule="+id_rule );
           
                //por defecto a regra se cumpre
                
                while (msql.next()) {
                  int id_device_action=msql.getInt("id_device");
                  double value_action=msql.getDouble("value");
                  println("Por o sensor: "+id_device_action+" co valor "+value_action);
                  myPort.write(id_device_action+","+value_action);
                }
           }           
           
        }
       
    } 
 
      
   }
   
   }
   
   
  
}
