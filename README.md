# TulipEasyJsonReader
Tulip Easy Json Reader

# Support
- Windows 32bit and 64bit (Console, VCL, FMX)
- Android (FMX)
- MacOS (FMX)

# Platform
. 

Read Json values exactly as properties.

# Before you start you should know:
 - **This tool is case sensitive.**
 - TulipEasyJsonReader for reading only. you cann't use it to change json values. ( at least for now. maybe later ).
 - TulipEasyJsonReader is a simple tool and it's build to be very simple. not to be full functional.
 - for Spaces in key names use two undersocres


 # How to use
 use the new property **jdata** of TJsonValue. ( it was before data )

```Delphi
  var
    Jval: TJsonValue;

  ..
   Edit1.Text := jval.jdata.LastName;
```

# example:

```json
{
   "First Name":"Samer",
   "LastName":"Assil",
   "AGE":47,
   "Lang":[
      "Arabic",
      "English",
      "Turkish"
   ],
   "Address":{
      "City":"Ankara",
      "Street":"B123",
      "Tel":[
         { "Home":"123123123" },
         { "Mobile":"123412341234", "Ext":9 }
      ]
   }
}
```


# Case Sensitive
```Delphi
  var
    Jval: TJsonValue;
   ...
  Edit1.Text := jval.jdata.AGE;
```

```Delphi
  var
    Jval: TJsonValue;
   ...
  // TulipEasyjsonReader is case sensitive.
  Edit1.Text := jval.jdata.LastName;
```

# Space in the key name
to get "First Name" value: // notice there is a space between Frist and Name
```Delphi
  var
    Jval: TJsonValue;
   ...
  // Use two underscores "__" instead of space
  Edit1.Text := jval.jdata.First__Name;
```



The return is Variant so you can assign it to a variable without warry about casting it. :)

```Delphi
  var
    Jval: TJsonValue;
   ...
  Edit1.Text := jval.jdata.Age; // using age value as string

  var MyAge: Integer;
  MyAge := jval.jdata.Age;  // here using age value as integer :)
```

# Reading from Array

```Delphi
  var
    Jval: TJsonValue;
   ...
   Edit1.Text := jval.jdata.Lang(1); // getting the second element value from the array object.
```


# Object in Array

get Address -> city
```Delphi
  var
    Jval: TJsonValue;
   ...
  Edit1.Text := jval.jdata.Address.City;
```

```Delphi
  var
    Jval: TJsonValue;
   ...

   Edit1.Text := jval.jdata.Address.Tel(1).Ext; // getting the "ext" value from the second element in "Tel" Array from Address Object :)
```

# Installation
No installation.. Just put TulipEasyJsonReader in uses section. and ready to go.
