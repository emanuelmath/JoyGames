using System;
using System.Collections.Generic;
using System.Text;

namespace JoyGames.Core.Exceptions
{
    public class DomainException(string msg) : Exception(msg);
}
