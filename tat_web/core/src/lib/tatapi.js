let apiUrl = 'http://localhost:8000/api/';

class TatApi {

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