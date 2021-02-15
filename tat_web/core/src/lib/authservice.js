import axios from 'axios'
let apiUrl = 'http://127.0.0.1:8000/api/auth/';

class AuthService {
    constructor() {
        this.token = window.localStorage.getItem('token');
        let userData = window.localStorage.getItem('user');
        if (userData !== 'undefined') {
            this.user = userData ? JSON.parse(userData) : null;
            if (this.token !== null) {
                axios.defaults.headers.common['Authorization'] = 'Bearer ' + this.token;
                this.getUser();
            }
        }
        // if (this.token) {
        //     axios.defaults.headers.common['Authorization'] = 'Bearer ' + this.token;
        //     this.getUser();
        // }
    }

    getUser() {
        api.call('get', apiUrl + 'get-user')
            .then(({ data }) => {
                this.user = data;
            });
    }

    doLogin(data) {
        console.log(data);
        var url = apiUrl + 'login';
        return api.call('post', url, data)
            .then(({ data }) => {
                return data
            });

    }

    login(token, user) {
        window.localStorage.setItem('token', token);
        window.localStorage.setItem('user', JSON.stringify(user));
        axios.defaults.headers.common['Authorization'] = 'Bearer ' + token;
        this.token = token;
        this.user = user;

        // EventBus.$emit('userLoggedIn');
    }

    logout() {
        axios.defaults.headers.common['Authorization'] = 'Bearer ' + this.token;
        if (this.token) {
            api.call('post', apiUrl + 'logout')
                .then(({ data }) => {
                    window.localStorage.removeItem('token');
                    window.localStorage.removeItem('user');
                    this.token = null;
                    this.user = null;
                    // EventBus.$emit('userLoggedOut');
                })
                .catch(({ response }) => {
                    window.localStorage.removeItem('token');
                    window.localStorage.removeItem('user');
                    this.token = null;
                    this.user = null;
                    // EventBus.$emit('userLoggedOut');
                });
        }

        // location.reload(true);

    }

    check() {
        return !!this.token;
    }
}

export default AuthService;