using JoyGames.Core.Enums;
using JoyGames.Core.Exceptions;
using System.Xml.Linq;

namespace JoyGames.Core.Entities
{
    public class Category
    {
        public int Id { get; private set; }
        public string Name { get; private set; }

        public Category(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new DomainException("El nombre de la categoría no puede ir vacío.");
            Name = name;
        }

        private Category() { }

        public CategoryEnum TranslateCategory()
        {
            return Enum.IsDefined(typeof(CategoryEnum), Id)
            ? (CategoryEnum)Id
            : throw new DomainException("No es una categoría válida.");
        }

        public void UpdateCategory(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new DomainException("El nombre de la categoría no puede ir vacío.");
            Name = name;
        }
    }
}
