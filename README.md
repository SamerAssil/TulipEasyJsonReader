# TulipEasyJsonReader
Tulip Easy Json Reader

Read Json values exactly as properties.

# Befor you start you must know. this TulipEasyJsonReady only work with capital letters json keys with now spaces in it.

# example:

```json
{
   "FIRSTNAME":"Samer",
   "LASTNAME":"Assil",
   "AGE":47,
   "LANG":[
      "Arabic",
      "English",
      "Turkish"
   ],
   "ADDRESS":{
      "CITY":"Ankara",
      "STREET":"B123",
      "TEL":[
         { "HOME":"123123123" },
         { "MOBILE":"123412341234", "EXT":9 }
      ]
   }
}
```


to get lastname value:
```Delphi
  Edit1.Text := jval.data.firstname;
```

get Address -> city
```Delphi
  Edit1.Text := jval.data.Address.city;
```


The return is Variant so you can assign it to a variable without warry about casting it. :)

```Delphi
  Edit1.Text := jval.data.age; // using age value as string
  
  var MyAge: Integer;
  MyAge := jval.data.age;  // here using age value as integer :)
```

# Reading from Array 
To access element in array use the keyward "elem" followd by the index of the element like: elem0, elem1, elem2.. 
the index as usual started with 0 

```Delphi
   Edit1.Text := jval.data.Lang.elem1; // getting the second element value from the array object.
```
 
# Object in Array
```Delphi
   Edit1.Text := jval.data.Address.Tel.elem1.Ext; // getting the "ext" value from the second element in "Tel" Array from Address Object :)
```


# Installation
No installation.. Just put TulipEasyJsonReader in uses section. and ready to go.
