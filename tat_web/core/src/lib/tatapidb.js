// let apiUrl = 'http://localhost:8000/api/';
let apiUrl = 'http://localhost:5005/api/';

class TatApiDb {

    getProfile(id) {
        var url = apiUrl + 'profile/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }
   
    getProfileList () {
        var url = apiUrl + 'profile';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }
    deleteProfile(id) {
        var url = apiUrl + 'profile/';
        return api.call('delete', url + id)
            .then(({ data }) => {
                return data
            });
    }

    updateProfile(data) {
        var url = apiUrl + 'profile/';
        return api.call('put', url + data.id, data)
            .then(({ data }) => {
                return data
            });
    }

    createProfile(data) {
        var url = apiUrl + 'profile';
        return api.call('post', url, data)
            .then(({ data }) => {
                return data
            });

    }

    getRole(id) {
        var url = apiUrl + 'role/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }
   
    getRoleList () {
        var url = apiUrl + 'role';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }
    deleteRole(id) {
        var url = apiUrl + 'role/';
        return api.call('delete', url + id)
            .then(({ data }) => {
                return data
            });
    }

    updateRole(data) {
        var url = apiUrl + 'role/';
        return api.call('put', url + data.id, data)
            .then(({ data }) => {
                return data
            });
    }

    createRole(data) {
        var url = apiUrl + 'role';
        return api.call('post', url, data)
            .then(({ data }) => {
                return data
            });

    }

    getOrganization(id) {
        var url = apiUrl + 'organization/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }
   
    getOrganizationList() {
        var url = apiUrl + 'organization';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }
    deleteOrganization(id) {
        var url = apiUrl + 'organization/';
        return api.call('delete', url + id)
            .then(({ data }) => {
                return data
            });
    }

    updateOrganization(data) {
        var url = apiUrl + 'organization/';
        return api.call('put', url + data.id, data)
            .then(({ data }) => {
                return data
            });
    }

    createOrganization(data) {
        var url = apiUrl + 'organization';
        return api.call('post', url, data)
            .then(({ data }) => {
                return data
            });

    }


    getLocationList() {
        var url = apiUrl + 'location';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }
    getLocation(id) {
        var url = apiUrl + 'location/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }
    deleteLocation(id) {
        var url = apiUrl + 'location/';
        return api.call('delete', url + id)
            .then(({ data }) => {
                return data
            });
    }

    updateLocation(data) {
        var url = apiUrl + 'location/';
        return api.call('put', url + data.id, data)
            .then(({ data }) => {
                return data
            });
    }

    createLocation(data) {
        var url = apiUrl + 'location';
        return api.call('post', url, data)
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

    getActivity(id) {
        var url = apiUrl + 'activity/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }
    deleteActivity(id) {
        var url = apiUrl + 'activity/';
        return api.call('delete', url + id)
            .then(({ data }) => {
                return data
            });
    }

    updateActivity(data) {
        var url = apiUrl + 'activity/';
        return api.call('put', url + data.id, data)
            .then(({ data }) => {
                return data
            });
    }

    createActivity(data) {
        var url = apiUrl + 'activity';
        return api.call('post', url, data)
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