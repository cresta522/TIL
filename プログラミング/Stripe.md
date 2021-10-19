### Stripeのフロント実装

#### 参考
https://blog.yuhiisk.com/archive/2018/10/05/customize-stripe-elements.html

https://arrown-blog.com/php-laravel-stripe-creditcard/
#### サンプル

```javascript

const stripe = Stripe('pk_test_*******************');
const elements = stripe.elements();

const elementStyles = { ... };
const elementClasses = { ... };

// カード番号
const cardNumber = elements.create('cardNumber', {
  style: elementStyles,
  classes: elementClasses,
});
cardNumber.mount('#card-number');

// カードの有効期限
const cardExpiry = elements.create('cardExpiry', {
  style: elementStyles,
  classes: elementClasses,
});
cardExpiry.mount('#card-expiry');

// カードのCVC入力
const cardCvc = elements.create('cardCvc', {
  style: elementStyles,
  classes: elementClasses,
});
cardCvc.mount('#card-cvc');


// トークンを作成
// cardNumberのみを指定する
stripe.createToken(cardNumber, {}).then(function(result) { ... });

```
