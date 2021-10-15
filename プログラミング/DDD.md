## ドメインオブジェクト
責務範囲の最小単位だと思った。

ユーザに関しての情報はユーザクラス(モデル)以外に記載しないのと同じ。

以下の総称
### エンティティ

MVCで言うところのモデルに該当すると思う。

ユーザなら"User"という概念そのもの。

厳密な定義としては
- **同一性(Identity)によって識別される**
- **同じ属性であっても区別される**

### 値オブジェクト

クラスが持つ属性(プロパティ)のこと。(Ex. 名前、年齢)

厳密な定義としては**同じ属性は区別されない**ことが挙げられる。

### 同じ属性での区別とは

「田中」という名前と「田中」という名前は文字として比較した場合同一であり区別されないが、
Userとして比較した場合は同名の人、という認識ができるため区別できるということ。

この場合前者が**値オブジェクト**であり後者が**エンティティ**。

### リポジトリ

クラスはクラスでも、データの永続化を司るクラス。

データの永続とは、
- データの追加
- データの更新
- データの削除

を指す。

Userという概念は、データの永続化をするものではなくされる側であるのだ。(User**が**登録するのではない。)

### ドメインサービス

Userの登録を行う場合、重複チェックを行う。その処理はどこに書くべきか？

UserクラスにExistsメソッドを入れた場合

```php
class User {
    public function Exists(User $user) {
        // ...    
    } 
}

$user = new User();
$user->Exists($user);
```

となるが、AというユーザはBというユーザの存在チェックを果たしてするのだろうか？

ドメイン(責務の範囲)という考えを用いると、これまたユーザ**が**チェックをするのではないため、不適なのだ。

このドメインオブジェクトが行って不自然になるメソッドを記載するのがドメインサービスである。

```php
class User {
}

class UserService {
    public function Exists(User $user) {
        // ...    
    } 
}

$user = new User();
$userService = new UserService();
if($userService->Exists($user)){
    // 存在してる
}
```

とするのが適切。

ドメインオブジェクトに記載されるメソッドはやろうと思えばすべてドメインサービスに記載することは可能。
しかし、そうするとドメインはプロパティを持つだけの存在になってしまうためそれも極端である。

私個人的には**引数に自クラスを取るようなメソッド**はドメインサービスなんだろうなと思っている。

ドメインオブジェクトには自分が主語になるようなメソッドを列挙すべきだ。

### アプリケーションサービス

これはMVCで言うところのControllerにあたると思われる。

Webアプリで言えばリクエストをもらい、レスポンスを返す存在。

DDD的に言えばユースケースを司る存在である。

### ここまでの纏め

```php
class UserName() 
{
    private $name;
    
    public function __construct(string $name): void
    {
        $this->name = $name;
    }
}

class User 
{
    public $userName;
    
    public function __construct(UserName $userName): void
    {
        $this->userName = $userName;
    }
}

interface IRepository 
{
    public function save(): void;
}

class UserRepository implements IRepository 
{
    public function save(User $user): void
    {
        // ..
    }
}

class UserService 
{
    public function Exists(User $user) 
    {
        // ...    
    } 
}

class UserApplicationService 
{
    public function main()
    {
        $user = new User();
        $userService = new UserService();
        $userRepository = new UserRepository();
        if(!$userService->Exists($user)){
            // 存在していない
            $userRepository->save($user);
        }    
    }
}

```

### DTO

ドメインオブジェクトを直接操作できることは危険だとして**DTO**(Data Transfer Object)を用いるのも手だと。

ただ、自作フレームワークならまだしも、LaravelのようなエンティティはDTO化できない気がするの。。

意図的にprivateにできないだろうし。


### Command

コマンドオブジェクトはDTOの考えに基づいている気がする。

何かって言うと、`UserUpdateCommand` ってクラスは**更新するUserクラス**ってこと。
ドメインオブジェクトに直接参照しないために作られ、同様に`UserDeleteCommand`や`UserInsertCommand`が作られる。

案件でも**Command**の概念は用いているところはあるが、LaravelのRequestのことだろうと思う。

### DDD用のLaravelカスタマイズ

`php artisan make:ddd User`
ってやるとオブジェクトサービスとかが作られるのはわくわくしそう。