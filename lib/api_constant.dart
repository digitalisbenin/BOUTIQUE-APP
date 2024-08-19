// api Urls
const baseUrl = "https://boutique.wadounnou.com/";
const assetUrlCategories = "assets/uploads/category_images/";
const assetUrlArticles = "assets/uploads/articles_images/";

const loginUrl = '${baseUrl}api/login';
const registerUrl = '${baseUrl}api/register';
const userUrl = '${baseUrl}api/user';

// categories
const categoriesUrl = '${baseUrl}api/categories';

// get all articles
const articlesUrl = '${baseUrl}api/articles';

// each categorie product
const categorieProductUrl = '${baseUrl}api/categorie-details';

// get product by categorie
const productByCategorieUrl = '${baseUrl}api/articles';

// add products to favorite
const addProductToFavoriteUrl = '${baseUrl}api/create-favoris';

// remove products from favorite
const removeProductFromFavoriteUrl = '${baseUrl}api/remove-favoris';

// get all users favorite product
const getAllUsersFavoriteProductUrl = '${baseUrl}api/favoris';

// add product to cart
const addProductToCartUrl = '${baseUrl}api/add-to-cart';

// delete product from cart
const deleteProductFromCartUrl = '${baseUrl}api/remove-cart';

// get cart product
const getAllUsersCartProductsUrl = '${baseUrl}api/mon-panier';

// update article quantity
const updateArticleQuantityUrl = '${baseUrl}api/update-cart';

// post an order
const postOrderUrl = '${baseUrl}api/placer-commande';

// user order list
const getAllUserOrderUrl = '${baseUrl}api/mes-commandes';

// get order detail
const getOrderDetailUrl = '${baseUrl}api/details-commande';

// get inscription info
const getInscriptionInfoUrl = '${baseUrl}api/inscription';

// update profil
const updateProfilUrl = '${baseUrl}api/profile';

// forgot password url
const forgotPaswordUrl = '${baseUrl}api/forgot-password';

// get bonus
const bonusUrl = '${baseUrl}api/bonus';

//---------- error ------------
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again';
