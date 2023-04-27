import 'package:carsa/models/user_model.dart';

  // const baseUrl = "https://4074-197-38-0-252.eu.ngrok.io";
  const baseUrl = "https://carsa.urapp.site";

const baseurlImage = baseUrl + "/images/";

String token = "";
String role = "";
UserModel currentUser = UserModel();

//end Points
const home = "/home";
const getCartsPoint = "/cart/get-carts";
const addCartPoint = "/cart/add-cart";
const deleteCartPoint = "/cart/delete-cart";
const updateCartPoint = "/cart/update-cart";
const validatePoint = "/auth/validate";
const loginPoint = "/auth/confirm-Code";
const registerPoint = "/auth/signup";
const getUserDetailsPoint = "/user/detail";
const updateUserDetailsPoint = "/user/update";
const checkUserNamePoint = "/auth/check-username";
const addFavPoint = "/fav/add-favorite";
const getFavPoint = "/fav/get-Favorites";
const deleteFavPoint = "/fav/delete-Favorite";
const uploadImagePoint = "/image/upload/car";
const getAddressesPoint = "/address/get-addresses";
const addAddressPoint = "/address/add";
const deleteAddressPoint = "/address/delete";
const updateAddressPoint = "/address/update";
const getPostsPoint = "/post/get-posts";
const addPostPoint = "/post/add-post";
const deletePostsPoint = "/post/delete-post";
const updatePostPoint = "/post/add-post";
const getCommentsPoint = "$baseUrl/comment/get-comments";
const addCommentPoint = "/comment/add-comment";
const deleteCommentPoint = "/post/delete-post";
const updateCommentPoint = "/post/add-post";

//PRODUCTS
const getProductsPoint = "/product/get-products";
const getProductsByCategoryPoint = "/product/get-products-by-category";
const searchProductsPoint = "/product/search-products";
const getOrdersPoint = "/order/get-orders";
const addOrderPoint = "/order/add-order";
const deleteOrderPoint = "/order/delete-order";
const getOrderDetailsPoint = "/order/get-Order-details";

// work shop
const getWorkshopsByCatIdPath = "$baseUrl/workshops/get-workshop-by-id";
const getCategoriesWorkshopsPath = "$baseUrl/category/get-categories-work";
//key shard
const userIdKey = "userId";
const tokenKey = "token";
const nameUserKey = "nameUser";
const phoneUserKey = "phone";
const userImageKey = "image";

// this.id,
// this.userName,
// this.fullName,
// this.imageUrl,
// this.status,
// this.role

String htmlData = """
   بسم الله الرحمن الرحيم
  الشروط والأحكام العامة لعملاء متجر car sa 
 
  تعتبر اتفاقية الشروط والأحكام هذه اتفاق رسمي بين متجر car sa والعملاء المستخدمين لمتجر car sa الراغبين بالاستفادة من الخدمات المتاحة فيها المقدمة من مزودي الخدمة.
ُيعد استخدامك للمتجر والخدمات المتاحة من خلاله موافقة على هذه الاتفاقية -اتفاقية الشروط والأحكام- وبذلك انت تقر وتوافق أن أي استخدام يتم من قبلك أو من قبل جهازك أو حسابك أو رقم يعود لك لأي من الخدمات التي يوفرها متجر car sa يعتبر موافقة منك على هذه الاتفاقية وأحكامها، وبناء على ذلك يجب عليك عدم استخدام المتجر في حال لم تكن موافقا على هذه الاتفاقية أو على شيء مما تضمنته هذه الاتفاقية.
نحتفظ بحقنا بتغيير الشروط والأحكام من وقت لآخر وعليه يتعين عليك الاطلاع على هذه الشروط والأحكام بشكل دوري
١-تعريفات "أنت صيغة المخاطب" تشير إلى مستخدم متجر car sa وتراعى كافة التعبيرات المؤدية إلى ذلك. "نحن صيغة المتحدث" تعني متجر car sa لخدمة
السيارات
٢-الشروط والأحكام تعني هذه الشروط والأحكام والتي قد تخضع للتعديل أو التغيير من وقت إلى آخر للاستخدام المشروع للدخول إلى متجر car sa يجب ألا يقل عمرك
عن 18 عاما. وأن تكون ذا أهلية قانونية كاملة للتعاقد والتعامل.
يجب ان تقدم معلومات صحيحة ودقيقة لـcar sa كما يجب عليك الالتزام لأي اشعارات يقوم بها متجرنا فيما يخص الخدمات التي نقدمها لضمان عدم تعرقل أي عمليات تشغيليه نقوم بها. يجب ان لا يكون استخدامك لخدمات car sa مسببا لأي إيذاء او مضايقه او ازعاج لأي شخص كان. المحافظة على كامل المحتويات والارقام السرية للدخول لحسابك بشكل امان.
يعتبر عنوان البريد الإلكتروني ورقم الهاتف وأي عناوين أخرى تابعة للعميل وسيلة رسمية للتواصل والإشعارات ويتم من خلال الإشعار بواسطتها قيام الحجة على تبليغ العميل.
في حال الطلب منك يجب ان تقدم ماطلبنا من الأوراق التي تثبت لنا هويتك او هوية المركبة الخاصة بك كما تحدد من متجرنا
يحق لمتجر car sa الامتناع عن الخدمة عند استخدام العميل للتطبيق بشكل خاطئ ، على سبيل المثال وليس الحصر (رفع أكثر من طلب لسيارة واحدة - أكثر من مستخدم لسيارة واحدة - التحايل لإستخدام العروض والخصومات والكوبونات) - لا يحق لك إلغاء أي خدمة بعد مرور يوم كامل من تأكيد طلبها من المتجر.
لا نتحمل مسؤولية تجاهك أو أي شخص آخر نتيجة أي خسارة ناجمة عن أمر لا سيطرة لنا عليه مثل الكوارث الطبيعية وغيرها
تعهد بالتزامنا المستمر من خلال سياستنا الخاصة بالسلامة بإتاحة استخدام موثوق للمنصة. عند استخدامك للمنصة يتوجب عليك دائما أخذ الاحتياطات التالية: المحافظة على سرية هويتك، لا تعطي اسمك الكامل، أو عنوانك البريدي، أو رقم
الهاتف، أو عنوان البريد الإلكتروني، أو غيرها من المعلومات (باستثناء المعلومات التي نطلبها تحديدا منك)، والتي قد يتمكن أحد ما من خلالها معرفة هويتك الحقيقية.
تقر وتوافق بتعويضنا نحن بشكل فوري وعند الطلب، عن كافة المطالبات، والالتزامات، والخسائر، والتكاليف، بما في ذلك الرسوم القانونية الناشئة عند ارتكابك أي خرق أو مخالفة لهذه الاتفاقية، أو عند تسببك بأي من الأضرار الناشئة عن استخدامك للمتجر تنشأ أو ترتبط بما يلي : - انتهاكك أو مخالفتك لأي شرط من شروط مقدم الخدمة الماثلة هذه أو لأي قانون أو لوئح معمول بها، سواء أشير اليها في شروط وأحكام الاستخدام هذه أم لا. - استخدامك أو إساءة استخدامك للتطبيق أو الخدمة.
وذلك بخصمها مباشرة من أي مبالغ يتم سدادها لخدمات أخرى من قبلكم. تنطبق هذه الشروط والأحكام بين متجرcar sa والعميل، ولا يحق لأي شخص آخر الاستفادة من هذه الأحكام والشروط.
  """;


String termsAndConditionsTitle = "الشروط والاحكام الخاصة بالورش ";

String termsAndConditionsData = """
 ١/ان يتحمل صاحب الورشة اي اضرار اتجاه السيارات التي قام صاحب الورشة بتصليحها .
٢/تطبيق car SA غير مسؤول عن تصليح السيارات يتحمل المسؤولية صاحب الورشة .
  """;

  String warrantyTitle = "سياسة ضمان الورش";

String warrantyData = """
١/تختلف من ورشه الى ورشه حسب سياسة الضمان الخاصة في الورشه نفسها .
٢/تطبيق car SA لايعطي ضمان نيابة عن الورشه.
  """;