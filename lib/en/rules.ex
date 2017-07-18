defmodule Lemma.En.Rules do

  @verb_rules [
    {"", "s"},
    {"y", "ies"},
    {"e", "es"},
    {"", "es"},
    {"e", "ed"},
    {"", "ed"},
    {"", "ing"},
    {"e", "ing"},
  ]

  @noun_rules [
    {"", "s"},
    {"s", "ses"},
    {"f", "ves"},
    {"x", "xes"},
    {"z", "zes"},
    {"ch", "ches"},
    {"sh", "shes"},
    {"man", "men"},
    {"y", "ies"}
  ]

  @adj_rules [
    {"", "er"},
    {"", "est"},
    {"e", "er"},
    {"e", "est"}
  ]

  def verbs do
    @verb_rules
  end

  def nouns do
    @noun_rules
  end

  def adjs do
    @adj_rules
  end
end