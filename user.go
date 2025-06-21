package todo

type User struct {
	Id       int    `json:"-"`        // Не сериализуется в JSON
	Name     string `json:"name"`     // JSON-поле "name"
	Username string `json:"username"` // JSON-поле "username"
	Password string `json:"password"` // JSON-поле "password"
}
