# shift

shift application
## Firestoreの構造
### Base
**/base**  
|パス|内容|
|---|---|
|type|休日などの情報種別|
|shift|シフト時間|
#### type
休日などの情報  
例では、以下のようにしています。  
|type|内容|
|---|---|
|0|休校|
|1|自習室のみ|
|10|開校|

0~9がシフト記入不可  
10~19がシフト記入可能  

#### shift
シフト記入などの情報  
例では、以下のようにしています。  

|type|内容|
|---|---|
|0|80分(時間間隔(分))|
|1|自習室のみ|
|10|開校|
|100|60分(時間間隔(分))|
|0|80分(時間間隔(分))|
|0|80分(時間間隔(分))|


type / 100 を従業員の役職ごとに設定します  
1の位が時間間隔を設定します。  
1の位が0の場合は自由に時間指定を行うことが出来ます。逆に、0以外である場合は指定時間間隔であることを示します。  
0~99がシフト記入不可  
100~199がシフト記入可能

#### position
従業員などの情報  
例では、以下のようにしています。  

|type|内容|
|---|---|
|0|Teacher|
|1|Office|

従業員の役職を設定します  

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
