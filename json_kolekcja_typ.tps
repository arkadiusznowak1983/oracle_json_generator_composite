create or replace type json_kolekcja_typ 
/* Moduł: generowanie JSON 
/* Przeznaczenie: Możliwość generowania w Oracle 12.1 danych JSON 
/* na podobieństwo JSON_OBJECT_T i JSON_ARRAY_T dostępnych w Oracle 12.2 
/* Autor: Arkadiusz Nowak 
/* Data: 2019.12.09 
/*  
/* Typ kolekcji (nested table) objektów typu "json_interface_typ" oraz dziedziczącego "json_typ". 
/* Wykorzystywany jako parametr do generowania stringa JSON 
/* 
/* Razem z "json_typ" i "json_interface_typ" tworzy kompozyt dla elementów JSON 
 */ 
is table of json_interface_typ;
/
