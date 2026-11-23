using JoyGames.Core.Exceptions;

namespace JoyGames.Core.Entities
{
    public class Company
    {
        public int Id { get; private set; }
        public string Name { get; private set; }
        public string Country { get; private set; }

        public Company(string name, string country)
        {
            if(string.IsNullOrWhiteSpace(name)) throw new DomainException("El nombre de la empresa no debe ser vacío.");
            if (string.IsNullOrWhiteSpace(country)) throw new DomainException("El nombre del país no debe ir vacío.");
            Name = name;
            Country = country;
        }

        public void UpdateCompany(string name, string country)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new DomainException("El nombre de la empresa no debe ser vacío.");
            if (string.IsNullOrWhiteSpace(country)) throw new DomainException("El nombre del país no debe ir vacío.");
            Name = name;
            Country = country;
        }
    }
}
