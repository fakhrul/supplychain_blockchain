// let apiUrl = 'http://localhost:8000/api/';
let apiUrl = 'http://192.168.0.118:8000/api/';

class TatApi {

    getLocationList() {
        var url = apiUrl + 'location';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }

    getActivityList() {
        var url = apiUrl + 'activity';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }

    getTrackList() {
        var url = apiUrl + 'trackhistory';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }

    getProductList() {
        var url = apiUrl + 'product';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }
    getProduct(id) {
        var url = apiUrl + 'product/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }
    deleteProduct(id) {
        var url = apiUrl + 'product/';
        return api.call('delete', url + id)
            .then(({ data }) => {
                return data
            });
    }

    updateProduct(data) {
        var url = apiUrl + 'product/';
        return api.call('put', url + data.id, data)
            .then(({ data }) => {
                return data
            });
    }

    createProduct(data) {
        var url = apiUrl + 'product';
        return api.call('post', url, data)
            .then(({ data }) => {
                return data
            });

    }


    getSpeciesList() {
        var url = apiUrl + 'species';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }
    getSpecies(id) {
        var url = apiUrl + 'species/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }

    deleteSpecies(id) {
        var url = apiUrl + 'species/';
        return api.call('delete', url + id)
            .then(({ data }) => {
                return data
            });
    }

    updateSpecies(data) {
        var url = apiUrl + 'species/';
        return api.call('put', url + data.id, data)
            .then(({ data }) => {
                return data
            });
    }

    createSpecies(data) {
        return api.call('post', 'http://localhost:8000/api/species', data)
            .then(({ data }) => {
                return data
            });

    }

}

export default TatApi;