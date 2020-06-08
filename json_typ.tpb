create or replace type body json_typ as 
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
  overriding member function toClob 
  return clob is 
    l_elementyClob   clob; 
    l_jest_nazwa     boolean := nazwa    is not null; 
    l_jest_wartosc   boolean := wartosc  is not null; 
    l_jest_objekt    boolean := objekt   is not null; 
    l_jest_elementy  boolean := elementy is not null; 
    l_count_elementy boolean := l_jest_elementy and elementy.count > 0; 
    l_nazwa          varchar2( 255 char ) := case when l_jest_nazwa then '"'||nazwa||'":' else null end; 
    l_element_jest_prosty boolean; 
  begin 
    -- element zwykly json, czyli para '"nazwa":"wartosc"' 
    if l_jest_nazwa and l_jest_wartosc then  
      return l_nazwa || '"'||wartosc||'"'; 
     
    -- element listy, czyli '"wartosc"' 
    elsif not l_jest_nazwa and l_jest_wartosc then  
      return '"'||wartosc||'"'; 
     
    -- element zlozony json, czyli para '"nazwa":{objekt}' 
    elsif l_jest_nazwa and l_jest_objekt then 
      return l_nazwa || '{'||objekt.toClob||'}'; 
     
    -- element json, czyli dane w '{ ... }' 
    elsif not l_jest_nazwa and l_jest_objekt then 
      return '{'||objekt.toClob||'}'; 
     
    -- elementy json w postaci '"nazwa": wartosc/objekt/tablica ' 
    elsif l_jest_elementy then 
      if l_count_elementy then 
        for indeks in elementy.first..elementy.last loop 
          -- sprawdza czy element kolekcji jest złożony czy prosty, jeżeli złożony to dodajemy klamerki 
          l_element_jest_prosty := elementy( indeks ).nazwa       is null 
                                   and elementy( indeks ).wartosc is not null; 
          -- string z posklejanymi elementami 
          l_elementyClob := l_elementyClob  
                         || case when not l_element_jest_prosty then '{' else null end 
                         || elementy( indeks ).toClob 
                         || case when not l_element_jest_prosty then '}' else null end; 
          -- przecinek 
          if indeks <> elementy.last then l_elementyClob := l_elementyClob || ', '; end if; 
        end loop; 
      end if; 
      return  l_nazwa || '['||l_elementyClob||']'; 
       
    -- pusty json, czyli '{}' 
    else  
      return '{}'; 
    end if; 
  end toClob; 
   
  -- konstruktor: pusty json 
  constructor function json_typ 
  return self as result is 
  begin return; end json_typ; 
   
  -- konstruktor: prosty atrybut tekstowy 
  constructor function json_typ( wartosc clob ) 
  return self as result is  
  begin 
    self.wartosc := wartosc; 
    return;  
  end json_typ; 
   
  -- konstruktor: json w klamerkach 
  constructor function json_typ( objekt json_interface_typ ) 
  return self as result is  
  begin 
    self.objekt := objekt; 
    return;  
  end json_typ; 
   
  -- konstruktor: typ złożony, czyli '"nazwa":{ ... }' 
  constructor function json_typ( nazwa  varchar2 
                                ,objekt json_interface_typ ) 
  return self as result is  
  begin 
    self.nazwa  := nazwa; 
    self.objekt := objekt; 
    return;  
  end json_typ; 
   
  -- konstruktor: typ nazwany elementu złożonego json '"nazwa": wartosc/tablica/objekt ' 
  constructor function json_typ( nazwa    varchar2 
                                ,elementy json_kolekcja_typ  ) 
  return self as result is  
  begin 
    self.nazwa    := nazwa; 
    self.elementy := elementy; 
    return;  
  end json_typ; 
   
  -- konstruktor: typ z nazwanym elementem json '"nazwa":"wartosc"' 
  constructor function json_typ( nazwa   varchar2 
                                ,wartosc clob 
                                ) 
  return self as result is  
  begin 
    self.nazwa   := nazwa; 
    self.wartosc := wartosc; 
    return;  
  end json_typ; 
end;
/