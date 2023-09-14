import { UserManager } from 'oidc-client';

const settings = {
  authority: "http://localhost:8080/realms/demo",
  client_id: "my-client",
  redirect_uri: "http://localhost:3000/signin-callback.html",
//   redirect_uri: "http://localhost:3000",
  response_type: 'code',
  scope: "openid profile message.read",
};

const userManager = new UserManager(settings);

export const getUser = () => {
    return userManager.getUser();
}

export const login = () => {
    return userManager.signinRedirect();
}

export const logout = () => {
    return userManager.signoutRedirect();
}
