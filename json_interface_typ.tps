create or replace type json_interface_typ as object( 
/* Aplikacjia: ODTWARZANIE_VSS  
/* Moduł: generowanie JSON 
/* Przeznaczenie: Możliwość generowania w Oracle 12.1 danych JSON 
/* na podobieństwo JSON_OBJECT_T i JSON_ARRAY_T dostępnych w Oracle 12.2 
/* Autor: Arkadiusz Nowak 
/* Data: 2019.12.09 
/*  
/* Typ objektowy "json_interface_typ" jest interfejsem dla typu "json_typ". Nie można 
/* tworzyć instancji objektu tego typu, a metoda "toClob" musi być przeciążona w subtypach. 
/* 
/* Razem z "json_typ" i typem tableof "json_kolekcja_typ" tworzy kompozyt dla elementów JSON 
 */ 
  nazwa   varchar2( 255 char ) 
 ,wartosc clob 
 ,not instantiable member function toClob return clob 
) not instantiable not final;
/