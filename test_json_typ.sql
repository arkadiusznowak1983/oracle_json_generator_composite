declare 
  l_lista json_kolekcja_typ := json_kolekcja_typ(); 
  l_json1 json_typ; 
  l_json2 json_typ; 
  l_json3 json_typ; 
  l_json4 json_typ; 
begin 
  l_lista.extend( 5 ); 
  l_lista( 1 ) := json_typ( 'atr1'  
                           ,'wartosc1' ); 
  l_lista( 2 ) := json_typ( 'atr2'  
                           ,json_kolekcja_typ( json_typ( 'lista1' ) 
                                              ,json_typ( 'lista2' ) 
                                              ) 
                           ); 
  l_lista( 3 ) := json_typ( 'atr3'  
                           ,json_typ( 'sub_atr3'  
                                     ,'sub_wartosc3' ) ); 
  l_lista( 4 ) := json_typ( 'atr4'  
                           ,'wartosc4' ); 
                            
  l_lista( 5 ) := json_typ( ); 
   
  l_json1 := json_typ( 'main_atr'  
                      ,l_lista ); 
                       
  dbms_output.put_line( '________________________' ); 
  dbms_output.put_line( l_json1.toClob() ); 
   
  l_json2 := json_typ( 'atrybut'  
                      ,l_json1    ); 
 
  dbms_output.put_line( '________________________' ); 
  dbms_output.put_line( l_json2.toClob() ); 
   
  dbms_output.put_line( '________________________' ); 
  l_json3 := json_typ(); 
  dbms_output.put_line( l_json3.toClob() ); 
   
  dbms_output.put_line( '________________________' ); 
  l_json4 := json_typ( l_json2 ); 
  dbms_output.put_line( l_json4.toClob() ); 
end;
/