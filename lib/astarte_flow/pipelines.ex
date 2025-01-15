#
# This file is part of Astarte.
#
# Copyright 2020 Ispirata Srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

defmodule Astarte.Flow.Pipelines do
  require Logger

  alias Astarte.Flow.Pipelines.Pipeline
  alias Astarte.Flow.Pipelines.DETSStorage

  @storage Application.compile_env(:astarte_flow, :pipelines_storage_mod, DETSStorage)

  def list_pipelines(realm) when is_binary(realm) do
    @storage.list_pipelines(realm)
  end

  def get_pipeline(realm, name) when is_binary(realm) and is_binary(name) do
    @storage.fetch_pipeline(realm, name)
  end

  def create_pipeline(realm, params) when is_binary(realm) and is_map(params) do
    changeset = Pipeline.changeset(%Pipeline{}, params)

    with {:ok, %Pipeline{} = pipeline} <- Ecto.Changeset.apply_action(changeset, :insert),
         :ok <- @storage.insert_pipeline(realm, pipeline) do
      {:ok, pipeline}
    end
  end

  def delete_pipeline(realm, name) when is_binary(realm) and is_binary(name) do
    @storage.delete_pipeline(realm, name)
  end
end
