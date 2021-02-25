import axios from 'axios'
let apiUrl = 'http://127.0.0.1:5005/api/auth/';

class AuthService {
    constructor() {
        this.token = window.localStorage.getItem('token');
        let userData = window.localStorage.getItem('user');
        if (userData !== 'undefined') {
            this.user = userData ? JSON.parse(userData) : null;
            if (this.token !== null) {
                axios.defaults.headers.common['Authorization'] = 'Bearer ' + this.token;
                console.log(this.token)
                axios.defaults.headers.common['api-token'] = this.token;
                
                // this.getUser();
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
            .then((response) => {
                console.log(response.data);
                return response.data
            });

    }

    recordLogin(token, user) {
        window.localStorage.setItem('token', token);
        window.localStorage.setItem('user', JSON.stringify(user));
        axios.defaults.headers.common['Authorization'] = 'Bearer ' + token;
        this.token = token;
        this.user = user;
    }

    logout() {
        axios.defaults.headers.common['Authorization'] = 'Bearer ' + this.token;
        if (this.token) {
            api.call('post', apiUrl + 'logout')
                .then(({ data }) => {
                    // EventBus.$emit('userLoggedOut');
                })
            // EventBus.$emit('userLoggedOut');
        };
        window.localStorage.removeItem('token');
        window.localStorage.removeItem('user');
        this.token = null;
        this.user = null;
    }

    check() {
        return !!this.token;
    }
}

export default AuthService;