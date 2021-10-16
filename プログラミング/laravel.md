### WEBページでArtisanコマンドを実行する

```php 
use Artisan;

Artisan::call('command:test', $argument_map_list);
```

#### 注意

この方法は、バックグラウンド実行にならない(非同期でない)ため、タイムアウトなどに注意。

必要に応じてQueue使う

### ファサードはなるべく略さない

`\Auth::user()`

などは定義元への参照ができないので、なるべく`\Auth`をuse して使う。

そうすれば定義元への参照が行える。