create or replace type json_typ under json_interface_typ( 
/* Aplikacjia: ODTWARZANIE_VSS  
/* Moduł: generowanie JSON 
/* Przeznaczenie: Możliwość generowania w Oracle 12.1 danych JSON 
/* na podobieństwo JSON_OBJECT_T i JSON_ARRAY_T dostępnych w Oracle 12.2 
/* Autor: Arkadiusz Nowak 
/* Data: 2019.12.09 
/*  
/* Typ objektowy generujący string JSON na podstawie parametrów wejściowych. 
/* Konstruktory o zróżnicowanych parametrach wejściowych pozwalają na utworzenie 
/* elementów tablicowych, prostych atrybutów tekstowych i złożonych struktur  
/* 
/* Razem z "json_kolekcja_typ" i "json_interface_typ" tworzy kompozyt dla elementów JSON 
 */ 
  objekt     json_interface_typ 
 ,elementy   json_kolekcja_typ 
 ,overriding member function toClob return clob 
  
  -- konstruktor: pusty json 
 ,constructor function json_typ return self as result 
  
  -- konstruktor: prosty atrybut tekstowy 
 ,constructor function json_typ( wartosc clob ) return self as result 
  
  -- konstruktor: json w klamerkach 
 ,constructor function json_typ( objekt json_interface_typ ) return self as result 
  
  -- konstruktor: typ złożony, czyli '"nazwa":{ ... }' 
 ,constructor function json_typ( nazwa  varchar2 
                                ,objekt json_interface_typ  
                                ) return self as result 
   
  -- konstruktor: typ nazwany elementu złożonego json '"nazwa": wartosc/tablica/objekt 
 ,constructor function json_typ( nazwa    varchar2 
                                ,elementy json_kolekcja_typ 
                                ) return self as result 
  
  -- konstruktor: typ z nazwanym elementem json '"nazwa":"wartosc"' 
 ,constructor function json_typ( nazwa   varchar2 
                                ,wartosc clob 
                                ) return self as result 
) final;
/