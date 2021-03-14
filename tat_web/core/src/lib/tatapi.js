// let apiUrl = 'http://localhost:8000/api/';
let apiUrl = 'http://localhost:5005/api/eth/';

class TatApi {

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

    getProfileByOrganization (id) {
        var url = apiUrl + 'profileByOrganization/';
        return api.call('get', url + id)
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

    getAreaList() {
        var url = apiUrl + 'area';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }

    getArea(id) {
        var url = apiUrl + 'area/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }

    getAreaByOrganization(id) {
        var url = apiUrl + 'areaByOrganization/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }

    deleteArea(id) {
        var url = apiUrl + 'area/';
        return api.call('delete', url + id)
            .then(({ data }) => {
                return data
            });
    }

    updateArea(data) {
        var url = apiUrl + 'area/';
        return api.call('put', url + data.id, data)
            .then(({ data }) => {
                return data
            });
    }

    createArea(data) {
        var url = apiUrl + 'area';
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

    getOrganizationType(id) {
        var url = apiUrl + 'organizationType/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }
   
    getOrganizationTypeList() {
        var url = apiUrl + 'organizationType';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }
    deleteOrganizationType(id) {
        var url = apiUrl + 'organizationType/';
        return api.call('delete', url + id)
            .then(({ data }) => {
                return data
            });
    }

    updateOrganizationType(data) {
        var url = apiUrl + 'organizationType/';
        return api.call('put', url + data.id, data)
            .then(({ data }) => {
                return data
            });
    }    


    createOrganizationType(data) {
        var url = apiUrl + 'organizationType';
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

    getActivityByOrganization(id) {
        var url = apiUrl + 'activityByOrganization/';
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


    getCategoryList() {
        var url = apiUrl + 'category';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }
    getCategory(id) {
        var url = apiUrl + 'category/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }

    deleteCategory(id) {
        var url = apiUrl + 'category/';
        return api.call('delete', url + id)
            .then(({ data }) => {
                return data
            });
    }

    updateCategory(data) {
        var url = apiUrl + 'category/';
        return api.call('put', url + data.id, data)
            .then(({ data }) => {
                return data
            });
    }

    createCategory(data) {
        var url = apiUrl + 'category';
        return api.call('post', url, data)
            .then(({ data }) => {
                return data
            });

    }

    getCertificationList() {
        var url = apiUrl + 'certification';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }
    getCertification(id) {
        var url = apiUrl + 'certification/';
        return api.call('get', url + id)
            .then(({ data }) => {
                return data
            });
    }
    deleteCertification(id) {
        var url = apiUrl + 'certification/';
        return api.call('delete', url + id)
            .then(({ data }) => {
                return data
            });
    }

    updateCertification(data) {
        var url = apiUrl + 'certification/';
        return api.call('put', url + data.id, data)
            .then(({ data }) => {
                return data
            });
    }

    createCertification(data) {
        var url = apiUrl + 'certification';
        return api.call('post', url, data)
            .then(({ data }) => {
                return data
            });

    }

    createTrail(data) {
        var url = apiUrl + 'trail';
        return api.call('post', url, data)
            .then(({ data }) => {
                console.log(data)
                return data
            });

    }

    getTrailList() {
        var url = apiUrl + 'trail';
        return api.call('get', url)
            .then(({ data }) => {
                return data
            });
    }
    
    getProductTrail(id) {
        var url = apiUrl + 'trail/';
        return api.call('get', url +id)
            .then(({ data }) => {
                return data
            });
    }

    getQrImage(id) {
        var url = apiUrl + 'generateQr/';
        return api.call('get', url +id)
            .then(({ data }) => {
                return data
            });
    }
}

export default TatApi;