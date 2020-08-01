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

**Database Structure**  

```
base----shift----0---type---1  
              |    |  
              |    --data---1---"23:00~0:00"  
              |           |  
              |           --2---"1:00~2:00"  
              |           |  
              |           --3---"3:00~4:00"  
              |  
              ---1---type---1  

```

type  
|type|value|
|---|---|
|0|時間のみの記入|
|1|ジャンル指定|
|2|ジャンル指定(△追加)|  
  
0は時間のみの記入  
1は◯とXでシフト登録する場合に使用します  
2は1に加えて△の項目を追加します。（使用者が日程があやふやな際に管理者側で把握するために用いる場合） 

typeの値によって従業員の役職ごとのシフト時間を設定します  
value部分がint型の「0」であれば、時間を自由に指定できます  
例として、以下のような選択肢を従業員側で選んでほしいという場合  
「1:00-2:00」、「3:00-4:00」、「5:00-6:00」、「7:00-8:00」  
dataにlist型でデータを入れます。  

また、shiftとtypeの間に挟まれている0や1の数値はpositionIDに紐付いています  

#### position
従業員などの情報  
例では、以下のようにしています。  

|type|役職|
|---|---|
|0|Teacher|
|1|Office|

従業員の役職を設定します  

###Shift(確定分)
**/shift/confirm**

###Shift(申請分)
**/shift/request**


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
