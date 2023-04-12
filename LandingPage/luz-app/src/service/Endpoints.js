import axios from "axios";

const httpClient = axios.create({
  baseURL: "https://localhost:8080",
  headers: {
    "Content-type": "application/json",
  },
});

export const getAll = () => {
  return httpClient.get("/cliente", {
    headers: { Authorization: "Bearer " + localStorage.getItem("jwtToken") },
  });
};

export const getById = (id) => {
  return httpClient.getById(`/cliente/${id}`
// , {
//     headers: { Authorization: "Bearer " + localStorage.getItem("jwtToken") },
//   }
);
};

export const create = (data) => {
  return httpClient.post("/cliente", data);
};

export const update = (id, data) => {
    return httpClient.put(`/cliente/${id}`, data
//   , {headers: { Authorization: "Bearer " + localStorage.getItem("jwtToken") }}
);
};

export const remove = (id) => {
  return httpClient.delete(`/cliente/${id}`
//   , {headers: { Authorization: "Bearer " + localStorage.getItem("jwtToken") }}
  );
};

export const exportExcel = () => {
  return httpClient.get("/cliente/export/excel", {
    responseType: "blob",
    // headers: { Authorization: "Bearer " + localStorage.getItem("jwtToken") },
  });
};

// export const login = (data) => {
//   return httpClient.post(
//     "/login",
//     {},
//     {
//       auth: {
//         username: data.nome,
//         password: data.senha,
//       },
//     }
//   );
// };