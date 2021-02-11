let apiUrl = 'http://localhost:8000/api/';

class TatApi {

    createSpecies(data) {
        alert(data)
        return api.call('post', 'http://localhost:8000/api/species', data)
            .then(({ data }) => {
                return data
            });

    }

}

export default TatApi;